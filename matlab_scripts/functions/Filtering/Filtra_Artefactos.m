function [ ecg_ok ] = Filtra_Artefactos( ecg, Fs, plot_flag )
%FILTRAARTEFACTOS Filtra los artefactos que puede tener una senyal ECG.
%   De momento simplemente filtra los outliers que tiene la senyal.
%   Esta función se llama desde el script Filtra_LineaBase. Para un uso
%   óptimo, mejor llamar a la función Filtra_LineaBase.

% INPUTS
%         ecg: Senyal a filtrar sus artefactos. Vector o Matriz de senyales
%          Fs: Frecuencia de muestreo
%   plot_flag: Flag que indica si crear o no un plot con las senyales -  Opcional


    if nargin < 3
        plot_flag = false;
    end

    [ ecg, ~, nchannels ] = AssertMatrixSize( ecg );
    ecg_ok = zeros(size(ecg));
    
    for i = 1 : nchannels
        for j = 1 : 1 %%%%% ????
        ecg_ok(:, i) = Filtra_ArtefactosAux(ecg(:, i), Fs, plot_flag);
        end
    end

end

function [ x_ok ] = Filtra_ArtefactosAux( x, Fs, plot_flag )

    if nargin < 3
        plot_flag = false;
    end
    
    x_ok = x;
    
    % Filtramos outliers segundo a segundo, tanto en mínimos como en máximos
    N_MUESTRAS       = length(x);
    winStep          = int32(Fs/2);
    iIni             = int32(1);
    iFin             = winStep;
    outliers_indexes = [];
    
    % Por si la senyal es menor que la ventana
    if iFin > N_MUESTRAS
        iFin = N_MUESTRAS;
    end
    
    mins = [];
    maxs = [];
    
    % Obtenemos los máximos y los mínimos según una ventana de tiempos
    while iFin <= N_MUESTRAS
        
        if iFin + winStep > N_MUESTRAS
            iFin = N_MUESTRAS;
        end
        
        senyal = x(iIni: iFin);
        
        mins = [mins; min(senyal)];
        maxs = [maxs; max(senyal)];
        
        iIni = iIni + winStep;
        iFin = iFin + winStep;
    end
    
    % Obtenemos los umbrales
    median_max  = median(maxs);
    median_min  = median(mins);
    std_max     = std(maxs);    
    std_min     = std(mins);
    
    % Necesitamos saber si el R es negativo o positivo
    if abs(median_max) > abs(median_min)
        coef_up = 4;
        coef_dn = 5;
    else
        coef_up = 5;
        coef_dn = 4;
    end
    
    
    % 1 - Detectamos los outliers
    umbral_up = median_max + (std_max * coef_up);
    umbral_dn = median_min - (std_min * coef_dn);
    
    ind_up = find(x > umbral_up);
    ind_dn = find(x < umbral_dn);
    outliers_indexes = sort([ind_up; ind_dn]);
    
    
    
    % 2 - Ponemos a zero los tramos donde los outliers están juntos    
    nOutliers = length(outliers_indexes);
    
    % Ponemos a cero los outliers
    if nOutliers >= 1
        x_ok(outliers_indexes) = 0;    
    end
    
    for i = 1 : nOutliers
        index = outliers_indexes(i);
        value = x(index);
        
        signo = sign(value);
        j = index-1;
        while j >= 1 && sign(x(j)) == signo
            x_ok(j) = 0;
            j = j - 1;
        end
        
        
        j = index+1;
        while j <= N_MUESTRAS && sign(x(j)) == signo
            x_ok(j) = 0;
            j = j + 1;
        end
    end
    
    % Ponemos a cero los tramos de senyal que tengan outliers muy cercanos
    if nOutliers > 1
        
        min_win = int32(Fs/2);
        for i = 1 : nOutliers-1
            iIni = outliers_indexes(i);
            iFin = outliers_indexes(i+1);
            
            % Si están muy cerca, ese tramo lo dejamos a cero
            if iFin-iIni <= min_win
                x_ok(iIni:iFin) = 0;
            end
            
            % Quitamos la ventana por delante y por detrás, normalmente
            % también son errores o senyal corrupta
%             aux = iIni - min_win;
%             if aux < 1
%                 aux = 1;
%             end
%             ecg_ok(aux:iIni) = 0;
%             
%             aux = iFin + min_win;
%             if aux > N_MUESTRAS
%                 aux = N_MUESTRAS;
%             end
%             ecg_ok(iFin:aux) = 0;
        end
        
    end
    
    
    
    if plot_flag == true
        
        T = getTimeVector(Fs, length(x_ok));        
        figure;
        
        % Senyal Original
        subplot(2, 1, 1);
        hold on
        if nOutliers > 0
            stem(T(outliers_indexes), ones(nOutliers, 1).*max(x_ok), 'r-');
        end
        plot(T, x);
        title('1-Senyal Original');
        xlabel('Time [s]');
        hold off
        grid;
        
        % Senyal Sin Línea Base
        subplot(2, 1, 2);
        hold on;
        if nOutliers > 0
            stem(T(outliers_indexes), ones(nOutliers, 1).*max(x_ok), 'r-');
        end
        plot(T, x_ok);                
        title('2-Senyal Sin Artefactos');
        xlabel('Time [s]');
        hold off;
        grid;
        
    end
end

