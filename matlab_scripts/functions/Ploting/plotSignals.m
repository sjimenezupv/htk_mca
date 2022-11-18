function [ G ] = plotSignals( Senyales, Fs, LblSenyales, G, mainTitle )
%PLOTSIGNALS Plotea las Senyales Contenidas en la cell o matriz especificada
%
% INPUTS
%       Senyales: Cell de N Senyales.
%       Senyales: Matriz de tamanyo [S, N], donde N es el número de Senyales y S el número de muestras
%             Fs: Opcional (Default 1). Frecuencia de Muestreo de las senyales.
%      mainTitle: Opcional (Default empty). Título principal del plot.
%    LblSenyales: Opcional (Default empty). Cell con una etiqueta para cada Senyal
%              G: Opcional (Default 0). Identificador que indica en qué plot dibujar


    if nargin < 2
        Fs = 1;
    end
    
    if nargin < 3 || isempty(LblSenyales);
        setLabels = false;
    else
        setLabels = true;
    end

    if nargin > 4 && G ~= 0
        figure(G);
    else
        G = figure;
    end
    
    
    
    if ~iscell(Senyales)
        [NumSamples, NumChannels] = size(Senyales);
        if NumChannels > NumSamples
            Senyales = Senyales';
            [NumSamples, NumChannels] = size(Senyales);
        end
        T = getTimeVector(Fs, NumSamples);
    else
        NumChannels = max(size(Senyales));
    end
    
    [ num_rows, num_cols ] = getBestSubplotSize( NumChannels );
    
    for i = 1 : NumChannels
        subplot(num_rows, num_cols, i);
        if ~iscell(Senyales)
            plot(T, Senyales(:, i));
        else
            T = getTimeVector(Fs, length(Senyales{i}));
            plot(T, Senyales{i});
        end
        
        if setLabels == true
            title(LblSenyales{i});
        end
    end
    
    if nargin > 4
            delete(findall(gcf, 'Tag', 'somethingUnique'))
            annotation('textbox', [0 0.9 1 0.1], ...
           'String', mainTitle, ...
           'EdgeColor', 'none', ...
           'HorizontalAlignment', 'center', ...
           'Interpreter', 'none', ...
           'Tag', 'somethingUnique');
    end


end

