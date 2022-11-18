function [G] = plot_ECG_Poincare(ecg, Fs, tit_figure, save_figures_sufix, save_dir, max_bpm)

    if nargin < 6, rr = getRRInterval( ecg, Fs );
    else           rr = getRRInterval( ecg, Fs, max_bpm );  end
    
    % Filtramos los outliers
    rr2 = Filtra_Outliers(rr);
    
    X = rr2;
    Y = rr2;
    
    X(end) = []; % n - 1
    Y(1)   = []; % n
    
    
%     %SD1
%     SD1 = sqrt(std(X-Y)/sqrt(2));
%     fprintf('SD1 = %f \n', SD1*1000);
% 
%     %SD2
%     SD2 = sqrt(std(X+Y)/sqrt(2));
%     fprintf('SD2 = %f \n', SD2*1000);
% 
%     %SDRR
%     SDRR=sqrt(SD1^2+SD2^2)/sqrt(2);
%     fprintf('SDDR = %f \n', SDRR*1000);

    % Establecemos los colores para cada 
%     [nelems, centers] = hist(rr2, 20);
%     clrs = Inf(size(X));
%     for i = 1:length(clrs)
%         value = X(i);
%         min_d = Inf;
%         nel_end = 0;
%         for j = 1 : length(centers)
%             center = centers(j);
%             nel    = nelems(j);
%             dist = abs(value - center);
%             if dist < min_d
%                 min_d = dist;
%                 nel_end = nel;
%             end
%         end
%         clrs(i) = nel_end;
%     end
    
    
    
    maxr = max(1, max(rr2));
    G = figure;
    subplot(2, 2, 1);
    plot(Y, X, '.');
    axis([0 maxr 0 maxr]);
    title('Poincaré Plot R-R');
    xlabel('RRn   [s.]');
    ylabel('RRn-1 [s.]');
    line([0 maxr], [0 maxr], 'LineStyle', '--', 'Color', 'k');
    grid;
    
    
    subplot(2, 2, 2); 
    ndhist(Y, X);    
    %hist3([Y, X], [50, 50]);    
    line([0 maxr], [0 maxr], 'LineStyle', '--', 'Color', 'k');    
    axis([0 maxr 0 maxr]);
    title('Histograma 2D - Poincaré Plot R-R');
    xlabel('RRn   [s.]');
    ylabel('RRn-1 [s.]');  
    grid;
    
    
%     scatter(X, Y, 10, clrs, 'fill')
%     axis([0 maxr 0 maxr]);
%     title('Poincaré Plot R-R');
%     xlabel('RRn   [s.]');
%     ylabel('RRn-1 [s.]');
%     line([0 maxr], [0 maxr], 'LineStyle', '--', 'Color', 'k');
%     colorbar;
%     grid;
    
    subplot(2, 2, 3);
    boxplot(rr); 
    title('Intervalos R-R');
    xlabel('R-R');
    ylabel('Tiempo R-R [s.]');
    grid;
    
    subplot(2, 2, 4);
    hist(rr, 0:0.025:1.5);
    xlim([0 1.5])
    title('Histograma R-R');    
    xlabel('Tiempo R-R [s.]');
    grid;
    
    if nargin >= 3    
        annotation('textbox', [0 0.9 1 0.1], ...
           'String', tit_figure, ...
           'EdgeColor', 'none', ...
           'HorizontalAlignment', 'center', ...
           'Interpreter', 'none');
    end
    
    if nargin >= 4 && ~isempty(save_figures_sufix)       
        if nargin < 5 && ~isempty(save_dir)
            save_dir = './';
        end        
        saveas(G, strcat(save_dir, 'rr_poincare_', save_figures_sufix, '.png'), 'png');
    end
    

end