function [ G ] = plotSpectrogram( x, Fs, FreqLims, normalize_psd01_flag, gray_flag, tit)
%PLOTSPECTROGRAM Summary of this function goes here
%   Detailed explanation goes here

    
    [S, F, T, P] = spectrogram(x, 1024, 512, 8192, Fs);
    S = abs(S);

    % Sólo los valores para Frecuencias < 30
    if length(FreqLims) == 2
        cond = F >= FreqLims(1) & F <= FreqLims(2);
        F = F(cond);
        P = P(cond, :);
        S = S(cond, :);
    end
    
    
    % Normalizar P en cada instante de tiempo
    %P = 10*log10(P);
    if normalize_psd01_flag == true
        n = length(T);
        for i = 1 : n
            P(:, i) = Scale01(P(:, i));
            S(:, i) = Scale01(S(:, i));
        end          
    end

    G = figure;
    %surf(T, F, S, 'edgecolor', 'none');
    h = pcolor(T, F, S);
    set(h, 'EdgeColor', 'none');

    if gray_flag == true
        colormap gray;       % select the colormap you wish to invert    
        cmap = colormap;     % get the matrix containing that colormap    
        cmap = flipud(cmap); % flip the matrix:    
        colormap(cmap);      % apply the new inverted colormap
    end


    axis tight;
    view(0,90);
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    
    if nargin >= 5        
        title(tit, 'Interpreter', 'none');
    end
    
end

