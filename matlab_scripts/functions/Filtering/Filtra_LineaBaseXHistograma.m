function [ ecg ] = Filtra_LineaBaseXHistograma( ecg, Fs, plot_flag )
%FILTRA_LINEABASEXHISTOGRAMA Elimina la linea base mediante el histograma
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
    
    for i = 1 : nchannels
        ecg(:, i) = Filtra_Aux(ecg(:, i), Fs, plot_flag);
    end
end
    
    
    function [ x ] = Filtra_Aux( x, Fs, plot_flag )
        
        values = unique(x);
        [nelements, centers] = hist(x, length(values)/2);

        % Cogemos el valor más frecuente y lo restamos
        [~, ind] = max(nelements);
        lb = centers(ind);
        
        
        if plot_flag == false
            x = x-lb;
        else
            T = getTimeVector(Fs, length(x));        
            figure;
            % Senyal Original
            subplot(2, 1, 1);
            plot(T, x);
            title('1-Senyal Original');
            xlabel('Time [s]');
            grid;
            
            % Para no repetir la operación 2 veces
            x = x-lb;

            % Senyal Sin Línea Base
            subplot(2, 1, 2);
            plot(T, x);
            title('2-Senyal Sin Línea Base');
            xlabel('Time [s]');
            grid;
        end
        
    end
%end

