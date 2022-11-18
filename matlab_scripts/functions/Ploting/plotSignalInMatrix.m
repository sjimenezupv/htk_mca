function [ G ] = plotSignalInMatrix( x, Fs, numSecsStep, numSecsToPlot, numSecsOffset, tit_figures, save_figures_sufix, save_dir)
%PLOTSIGNALINMATRIX Plotea la senyal en X en una matriz de subplots.


    if nargin < 3,  numSecsStep = 5;         end
    if nargin < 5,  tit_figures = 'Signals'; end
    save_flag = nargin >= 7;


    END    = length(x);
    window = Fs*numSecsToPlot;
    T      = getTimeVector(Fs, numSecsToPlot*Fs);
    
    
    total_secs     = floor(END/Fs);
    num_charts     = floor(total_secs/numSecsStep)+1;
    total_mins_str = int2str(ceil(total_secs/60));
    
    [num_rows, num_cols] = getBestSubplotSize(num_charts);    
    G=figure;

    for i = 0 : num_charts-1

        iIni = (i * numSecsStep * Fs) + 1 + (Fs * numSecsOffset);
        iFin = iIni + window - 1;
        if iFin > END
            iFin = END;
            T    = getTimeVector(Fs, iFin-iIni);
            if length(T) < 1
                continue;
            end
        end
        
        % Adquirimos el trozo de senyal y lo ploteamos    
        senyal  = x(iIni:iFin);        
        sec     = floor(iIni/Fs);
        minuto  = (sec/60)+1;
        min_str = int2str(minuto);
        tit     = ['Min ', min_str, '/', total_mins_str];
        
        subplot(num_rows, num_cols, i+1);
        plot(T, senyal);
        xlabel('Time (s)');
        title(tit);
        grid;
    end
    
    % Imprimimos el título del plot
    annotation('textbox',             [0 0.9 1 0.1], ...
               'String',              tit_figures, ...
               'EdgeColor',           'none', ...
               'HorizontalAlignment', 'center', ...
               'Interpreter',         'none');
    
    if save_flag == true
        saveas(G, strcat(save_dir, 'matriz_senyales_', save_figures_sufix, '.png'), 'png');
    end

end

