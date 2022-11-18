function [ S ] = getVCG_Features( vcg, debug_flag, verbose_flag )
%GETVCG_FEATURES Summary of this function goes here
%   Detailed explanation goes here

    if nargin < 2
        debug_flag = false;
    end
    
    if nargin < 3
        verbose_flag = false;
    end


    [n, ~] = size(vcg);
    phi    = zeros(1, n-2);
    
    % Hacer el círculo completo? (falta un punto)
    for i = 2 : n-1
        
        v1 = vcg(i-1, :)';
        v2 = vcg(i,   :)';
        v3 = vcg(i+1, :)';
        
        z1 = v2 - v1;
        z2 = v3 - v2;
        
        nz1 = norm(z1);
        nz2 = norm(z2);
        
        phi(i) = acos( (z1'* z2) / ( nz1 * nz2 ));
        
    end
    
    S(1) = (2*pi) / sum(phi); % Parámetro S
    
    
    % Otro marcador
    y = vcg(:, 1);
    X = vcg(:, [2, 3]);

    
    X = [ones(length(y), 1), X];
    [b, ~, ~, ~, stats] = regress(y, X);    
    S(2) = stats(1); % Parámetro R2

    
%     x1 = vcg(:, 2);
%     x2 = vcg(:, 3);    
%     y  = vcg(:, 1);
    
    x = vcg(:, 1);
    y = vcg(:, 2);    
    z = vcg(:, 3);
    
    xhat = b(1) + b(2)*y + b(3)*z;
    D = sqrt(sum((x-xhat).^2)); % Distancia
    %D = sqrt(max((x-xhat).^2)); % Distancia
    S(3) = D / n;               % Distancia media (D1)
    S(4) = power(D, 1/n);       % Distancia geométrica (D2)
    
    S(5) = sum(phi) * 180 / pi; %% Suma de grados en Degrees
    
%     S(3) = 0;
%     for i = 1 : n
%         S(3) = S(3) + sqrt((y(i)-yhat(i)).^2);
%     end
%     S(3) = S(3) / n;
%     
%     
%     S(4) = 1;
%     for i = 1 : n
%         S(4) = S(4) * sqrt((y(i)-yhat(i)).^2);
%     end
%     S(4) = power(S(4), 1/n);
    


    %return
    %close all
    
    if verbose_flag == true
        fprintf('S=%f  R2=%f  D1=%f\n', S(1), S(2), S(3));
    end
    
    if ~debug_flag
        return;
    end
    
        % Para la SEC 2017
%     figure;
%     subplot(1, 3, 1); plot_aux(x, y, z, b); az = 45; el = 45; view([az, el]);    
%     subplot(1, 3, 2); plot_aux(x, y, z, b); az = 120; el = 45; view([az, el]);
%     subplot(1, 3, 3); plot_aux(x, y, z, b); az = 210; el = 45; view([az, el]);
    figure;
    subplot(1, 2, 1); plot_aux(x, y, z, b); az =  45; el = 20; view([az, el]);    
    subplot(1, 2, 2); plot_aux(x, y, z, b); az = 135; el = 20; view([az, el]);
    %title('Vcg'); % z, y
    AX=legend('VCG', 'Plano', 'Location', 'SouthEast');
    LEG = findobj(AX,'type','text');
    set(LEG,'FontSize', 14, 'FontStyle', 'Bold');
    
    return;
    
    figure;
    subplot (3, 2, 1);
    plot_aux(x, y, z, b); grid;
    title('6286141'); view(3);
    
    subplot (3, 2, 2);
    plot_aux(x, y, z, b); 
    az = 0; el = 0; view([0 0 1]);
    title('Frontal'); % x, y
    
    subplot (3, 2, 3);
    plot_aux(x, y, z, b);
    az = 90; el = 0; view([0 -1 0]);
    title('Transversal'); % x, z
    
    subplot (3, 2, 4);
    plot_aux(x, y, z, b);
    az = 90; el = 0; view([az, el]);
    title('Sagital'); % z, y
    
    
    
    
%     x = vcg(:, 1);
%     y = vcg(:, 2);    
%     z = vcg(:, 3);
    Fs = 500;
    N  = length(x);
    T  = getTimeVector(Fs, N) .* 1000;
    ymn = min([x; y; z]);
    ymx = max([x; y; z]);
    yl  = [ymn; ymx];
    subplot (3, 3, 7);  plot(T, x);  ylabel('X'); xlabel('Time (ms.)'); grid; ylim(yl);
    subplot (3, 3, 8);  plot(T, y);  ylabel('Y'); xlabel('Time (ms.)'); grid; ylim(yl);
    subplot (3, 3, 9);  plot(T, z);  ylabel('Z'); xlabel('Time (ms.)'); grid; ylim(yl);
    


end

function plot_aux(x, y, z, b)

    % x es la variable dependiente

    hold on
    %axis off;
    line(x, y, z, 'LineWidth', 3, 'Color', 'b')
    %scatter3(x, y, z, 'filled')
    hold on
    yfit = linspace(min(y), max(y), 15);
    zfit = linspace(min(z), max(z), 15);
    [YFIT, ZFIT] = meshgrid(yfit, zfit);
    XFIT = b(1) + b(2)*YFIT + b(3)*ZFIT;
    
    surf(XFIT, YFIT, ZFIT, 'facecolor', 'red', 'facealpha', 0.8, 'EdgeColor', 'none');
    %mesh(X1FIT,X2FIT,YFIT);
%     AX=legend('VCG', 'Plano');
%     LEG = findobj(AX,'type','text');
%     set(LEG,'FontSize',14, 'FontStyle', 'Bold');
%     
    
    
    %line(x, y, z);
    
    % PLOT AXIS
    xa = [min(x) max(x)]; [~, idxx] = max(abs(xa));
    ya = [min(y) max(y)]; [~, idxy] = max(abs(ya));
    za = [min(z) max(z)]; [~, idxz] = max(abs(za));
    
%     xa = [-1, 1 ];
%     ya = [-1, 1 ];
%     za = [-1, 1 ];
    p0 = [0, 0];
    lw = 2;
    line(xa, p0, p0, 'Color','k', 'LineWidth', lw); 
    line(p0, ya, p0, 'Color','k', 'LineWidth', lw);
    line(p0, p0, za, 'Color','k', 'LineWidth', lw);
    
     text(xa(idxx)*1.15, 0, 0, 'X', 'FontSize', 14)
     text(0, ya(idxy)*1.15, 0, 'Y', 'FontSize', 14)
     text(0, 0, za(idxz)*1.15, 'Z', 'FontSize', 14)
    
    %[n,V,p] = affine_fit(vcg, true);
    set(gca,'xtick',[])
    set(gca,'ytick',[])
    set(gca,'ztick',[])
    
    
    fs = 11;
    %xlabel('X', 'FontSize', fs, 'FontWeight', 'bold');
    %ylabel('Y', 'FontSize', fs, 'FontWeight', 'bold');
    %zlabel('Z', 'FontSize', fs, 'FontWeight', 'bold');
    view(50, 10)
    hold off

end

