function [ ] = plotBoxPlots( Table, class, Vars, SaveDir, SheetName )
%PLOTBOXPLOTS Summary of this function goes here
%   Detailed explanation goes here

    if nargin < 2
        Vars = Table.Properties.VariableNames;
    end
    plot_flag = nargin >= 5;
    

    NVars = length(Vars);
    [nr, nc] = getBestSubplotSize(NVars);
   

    g1 = figure;
    g2 = figure;
    for i = 1 : NVars

        if iscell(Table.(Vars{i}))
            x = cell2mat(Table.(Vars{i}));
        else
            x = Table.(Vars{i});
        end

        figure(g1);
        subplot(nr, nc, i);
        boxplot(x, class);
        %ylim([-1.1 1.1])
        %set(gca,'YTick', -1:0.25:1)
        grid
        tit = strrep(Vars{i}, '_', ' ');
        title(tit, 'Interpreter', 'none');
        ylabel('mV');%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Cambiar según las necesidades
        
        % Plot Individual
        figure(g2);        
        boxplot(x, class);
        %ylim([-1.1 1.1])
        %set(gca,'YTick', -1:0.25:1)
        grid
        
        
        title(tit, 'Interpreter', 'none');
        ylabel('mV');%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Cambiar según las necesidades
        % Gráfica con el Boxplot Individual
        if plot_flag
            fname = [SaveDir, 'BP.', SheetName, '.', Vars{i}, '.png'];

            figure(g2);
            set(gcf, 'Position', get(0,'Screensize'));
            print(g2, '-dpng', '-r300', fname);
            %close all; % Para no saturar la máquina abriendo demasiados plots
        end
        
        
        
        
    end
    
    
    
    
    % Gráfica con todos los Boxplots - Si hemos de plotear las figuras
    if plot_flag
        fname = [SaveDir, 'BP.', SheetName, '.png'];

        figure(g1);
        set(gcf, 'Position', get(0,'Screensize'));
        print(g1, '-dpng', '-r300', fname);
        %close all; % Para no saturar la máquina abriendo demasiados plots
    end

end

