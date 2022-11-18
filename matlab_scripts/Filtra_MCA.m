function [ Y ] = Filtra_MCA( Y, Fs, debug_flag )

    if nargin < 3
        debug_flag = false;
    end

    %%
    if debug_flag
        figure(1);
        cla
        hold on;
        plot(Y(:, 1), 'r-');
    end
    
    
    %% 
    
    Y = Filtra_Artefactos( Y, Fs, false );    
    if debug_flag, plot(Y(:, 1), 'g-'); end   



    %% Filtro Paso Bajo (60-80Hz)
    %Y = FiltraPB(Y, Fs, 70);
    [a, b] = getFiltroPB(Fs, 70);
    Y = Filtra(Y, a, b);
    if debug_flag, plot(Y(:, 1), 'b-'); end
    
    
    
    %% Filtro Notch (50 Hz)
    [a, b] = getFiltroNotch( Fs, 50 );
    Y = Filtra(Y, a, b);
    if debug_flag, plot(Y(:, 1), 'c-'); end
    
    

    

    
    
    
    %% Filtron Paso Alto (0.7 Hz)
    %Y = FiltraPA(Y, Fs, 0.7);
    [a, b] = getFiltroPA(Fs, 0.7);
    Y = Filtra(Y, a, b);
    if debug_flag, plot(Y(:, 1), 'm-'); end
    
    
    % Quitamos el transitorio, sacrificando 1 segundo de senyal
    Y = CutSignal( Y, Fs, 0.5, 0.5 );
    
    % Restamos la Moda para centrar en cero
    %mean(Y)
    modeY = mode(round(Y*1000)/1000);
    
    if debug_flag
        modeY
        size(Y)
        size(modeY)
    end
    for i=1:12
        Y(:, i) = Y(:, i) - (modeY(i));
    end
    
    
    %% Final Debug
    if debug_flag
        plot(Y(:, 1), 'k-'); 
        hold off;
        legend('orig', 'noartifact', 'pb', 'notch', 'pa', 'mode');
        grid        
        
        figure(2)
        plot(Y);
        grid;
        
        pause;
    end
    
end






function [ y ] = Filtra(x, a, b)    
    y  = AplicaFiltFilt(x, a, b);
end


function [a, b] = getFiltroNotch(Fs, Fc)


    Q  = 10;
    Fn = Fs/2;
    
    W0 = Fc/Fn;
    bw = W0/Q; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %bw = 0.1;
    
    
    [b, a] = iirnotch(W0, bw);

end


function [a, b] = getFiltroPB(Fs, Fc)

% % % %     Rp = 0.5; % Db de atenuación en la banda que pasa
% % % %     Rs = 15;  % Db de atenuación en la stopband
% % % % 
% % % %     Fn = Fs/2;
% % % %     
% % % %     % Wp < Ws
% % % %     Wp = Fc/Fn;
% % % %     Ws = (Fc+5)/Fn;  % Para que atenue los 15 db dejamos un margen de 5 Hz
% % % %     
% % % %     [n, Wn] = buttord(Wp, Ws, Rp, Rs);
% % % %     [b, a] = butter(n, Wn);%, 'low');
% % %     
     Wn = Fc/(Fs*0.5);
    [b, a]  = butter(4, Wn);

end

function [a, b] = getFiltroPA(Fs, Fc)

% % % %      rp = 3;
% % % %      rs = 60;
% % % %     
% % % %     %rp = 0.5;
% % % %     %rs = 15;
% % % % 
% % % %     Fn = Fs/2;
% % % %     
% % % %     % Wp > Ws
% % % %     Wp = (Fc+5)/Fn;
% % % %     Ws = Fc/Fn;  % Para que atenue los 15 db dejamos un margen de 5 Hz
% % % %     
% % % %     [n, Wn] = buttord(Wp, Ws, rp, rs);
% % % %     [b, a]  = butter(n, Wn, 'high');
    
    Wn = Fc/(Fs*0.5);
    [b, a]  = butter(4, Wn, 'high');
end

