function [ G ] = plot12Deriv( Y, Fs, tit, G, R_Indices )
%PLOT12DERIV Plotea las 12 Derivaciones de una senyal

    derivs = {'I', 'II', 'III', 'aVR', 'aVL', 'aVF', 'V1', 'V2', 'V3', 'V4', 'V5', 'V6' };

    if nargin > 3 && G ~= 0
        figure(G);
    else
        G = figure;
    end
    
    if nargin < 5
        rt = [];
    else
        rt = R_Indices ./ Fs;
        ot = ones(size(rt));
    end
        
    
    [NumSamples, NumChannels] = size(Y);
    if iscell(Y) == 0 && NumChannels > NumSamples
        Y = Y';
        [NumSamples, NumChannels] = size(Y);
    elseif iscell(Y) == 1
        NumChannels = max(size(Y));
    end    
    
    [ num_rows, num_cols ] = getBestSubplotSize( NumChannels );
    

    
    clf;
    for i = 1 : NumChannels
        subplot(num_rows, num_cols, i);        
        hold on;
        
        if iscell(Y) == 0
            T = getTimeVector(Fs, NumSamples);
            plot(T, Y(:, i));
            grid;
            
            if ~isempty(rt)
                mx = max(Y(R_Indices, i));
                mi = min(Y(R_Indices, i));
                if abs(mi) > abs(mx)
                    mx = mi;
                end
                stem(rt, ot .* mx, 'r-');
            end
        else
            T = getTimeVector(Fs, length(Y{i}));
            plot(T, Y{i});
            grid;
            
            if ~isempty(rt)
                mx  = max(Y{i});
                mi = min(Y{i});
                if abs(mi) > abs(mx)
                    mx = mi;
                end
                stem(rt, ot .* mx, 'r-');
            end
        end
        hold off;
        
        if i <= length(derivs)
            title(derivs{i});
        end
        
    end
    
    % Borramos el título si tenemos que plotear en una gráfica anterior
    if nargin > 3
        delete(findall(gcf,'Tag','somethingUnique'))
    end
    
    % Ponemos el título
    if nargin > 2
            annotation('textbox',             [0 0.9 1 0.1], ...
                       'String',              tit, ...
                       'EdgeColor',           'none', ...
                       'HorizontalAlignment', 'center', ...
                       'Interpreter',         'none', ...
                       'Tag',                 'somethingUnique');
    end


end

