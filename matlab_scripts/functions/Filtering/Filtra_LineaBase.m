function [ ecg_nolb ] = Filtra_LineaBase(ecg, Fs, plot_flag)
%FILTRO_LINEA_BASE Elimina la linea base del vector o matriz de ecgs. 
% Se remuestrea la señal a una frecuencia N veces inferior a fs, se
% filtra paso bajo a 0,7, y el resultado se remuestrea a la frec original fs
% y se le resta a la señal original. Finalmente se resta la media.
%
% INPUTS 
%        ecg: Señal con línea base. Puede ser la matriz de senyales.
%         Fs: Frecuencia de muestreo
%  plot_flag: Indica si se han de plotear o no las senyales - Opcional
% 
% OUTPUTS
%   ecg_nolb: Señal sin línea base

    if nargin < 3
        plot_flag = false;
    end

    [ ecg, ~, nchannels ] = AssertMatrixSize( ecg );
    ecg_nolb = zeros(size(ecg));
    
    for i = 1 : nchannels
        ecg_nolb(:, i) = Filtra_LineaBaseAux(ecg(:, i), Fs, plot_flag);
    end
end

    
    
function [ x_nolb ] = Filtra_LineaBaseAux(x, Fs, plot_flag)

    if nargin < 3
        plot_flag = false;
    end


    % Se anyaden dos segundos al principio y al final, para que las transiciones salgan bien
    secOff = 6;
    canal_mod=[zeros(secOff*Fs,1); x; zeros(secOff*Fs,1)]; 
    nS=length(canal_mod); % Número de muestras
    N=20;                 % Factor de diezmado
    fsd=Fs/N;             % Frecuencia de diezmado


    % Aplicamos filtro paso-bajo a 40Hz antialiasing y diezmamos
    [b1, a1]=butter(10, 40/(Fs/2));  
    filtrada=filtfilt(b1, a1, canal_mod);
    diezmada=filtrada(1:N:end);

    % Aplicamos filtro paso-bajo a 1 Hz a la senyal diezmada para obtener
    % la línea base
    [b2,a2]=butter(3, 1/(fsd/2));
    lbase_fsd=filtfilt(b2, a2, diezmada);

    % Interpolamos la linea base diezmada a una linea base de la Frecuencia Inicial
    lbase_fs=interp(lbase_fsd, N);

    % Para q las longitudes sean las mismas y se pueda restar
    nP=length(lbase_fs);
    nF=min(nS,nP); 

    % Quitamos los secOff segundos iniciales y finales (zeros) y restamos la
    % media
    x_nolb=canal_mod(1:nF)-lbase_fs(1:nF);
    x_nolb=x_nolb(secOff*Fs+1:end-secOff*Fs);
    x_nolb=x_nolb - mean(x_nolb);

    % Además, quitamos los artefactos, sin plotear nada
    if plot_flag == false
        x_nolb=Filtra_Artefactos(x_nolb, Fs, false);
    else
        ecg_nolb2=Filtra_Artefactos(x_nolb, Fs, false);
        T = getTimeVector(Fs, length(ecg_nolb2));

        figure;

        % Senyal Original
        subplot(3, 1, 1);
        plot(T, x);
        title('1-Senyal Original');
        xlabel('Time [s]');
        grid;

        % Senyal Sin Línea Base
        subplot(3, 1, 2);
        plot(T, x_nolb);
        title('2-Senyal Sin Línea Base');
        xlabel('Time [s]');
        grid;

        % Senyal Sin Artefactos
        subplot(3, 1, 3);
        plot(T, ecg_nolb2);
        title('3-Senyal Sin Artefactos');
        xlabel('Time [s]');
        grid;

        % Resultado final
        x_nolb = ecg_nolb2;
    end
end


