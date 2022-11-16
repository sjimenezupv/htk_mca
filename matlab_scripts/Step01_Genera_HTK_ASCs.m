close all;

% Script para generar los ficheros .ascii
% Que posteriormente convertiremos a formato HTK
debug_flag   = false;
DIR_PATH_OUT = 'E:/000_Tesis_2022/MCA/data/HTK_ASC/ASC/';


NumSignals = length(SENYALES);

for i = 1 : NumSignals
    
    % Get the i-signal    
    Sx = SENYALES{i};
    Fs = Sx.Fs;
    
    % File name 
    fname_out = [Sx.class_str, '.', Sx.id, '.asc'];    
    
    % Full path
    path_out = [DIR_PATH_OUT, fname_out];    
    
    % Debug
    fprintf('[%2d / %2d] -> %s \n', i, NumSignals, fname_out);  
    
    % Get the filtered signal
    Y = Sx.YFiltrada;
     
    % 1st and 2nd derivative
    Y_D1   = diff(Y);    Y_D1 = [zeros(1, 12); Y_D1];
    Y_D2   = diff(Y_D1); Y_D2 = [zeros(1, 12); Y_D2];
    
    % Primeras 3 componentes de la PCA
    [C, ] = pca(Y');
    Y_PCA = C(:, 1:3); % Sólo las tres primeras componentes
    
    % Vectocardiograma (3 componentes)
    Y_VCG = getVCG( Y );
      
    % Debug
    if debug_flag == true 
        figure;
        plot12Deriv(Y,     Fs, [fname_out, ' - FILTRADA']);
        plot12Deriv(Y_D1,  Fs, [fname_out, ' - DERIVADA 1']);
        plot12Deriv(Y_D2,  Fs, [fname_out, ' - DERIVADA 2']);
        plot12Deriv(Y_PCA, Fs, [fname_out, ' - PCA']);
        plot12Deriv(Y_VCG, Fs, [fname_out, ' - VCG']);
        pause;
    end
    close all
    
    % Generamos la matriz final    
    Y = [Y, Y_D1, Y_D2, Y_PCA, Y_VCG];    
    dlmwrite(path_out, Y, '\t');
end
