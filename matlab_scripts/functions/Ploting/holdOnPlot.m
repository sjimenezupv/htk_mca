function [ G ] = holdOnPlot( x, y_cell, tit, x_label, y_label, legends, G )
%HOLDONPLOT Plotea la senyal de cada vector contenido en la cell y_cell.


    if   nargin < 7, G = figure;
    else                 figure(G); end
    
    
    colors = {'c-', 'b-', 'r-', 'm-', 'g-', 'k-', 'y-'};
    n      = length(y_cell);
    
    hold on
    
    for i = 1 : n
        clr = colors{mod(i, 7)+1};

        if isempty(x),  plot(   y_cell{i}, clr);
        else            plot(x, y_cell{i}, clr);        end
    end
    
    if ~isempty(tit),      title(tit);       end
    if ~isempty(x_label),  xlabel(x_label);  end
    if ~isempty(y_label),  ylabel(y_label);  end
    if ~isempty(legends),  legend(legends);  end
    
    grid
    hold off

end

