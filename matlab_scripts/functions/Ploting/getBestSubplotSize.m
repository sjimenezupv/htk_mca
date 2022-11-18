function [ num_rows, num_cols ] = getBestSubplotSize( num_plots )
%GETBESTSUBPLOTSIZE Obtiene el mejor tamanyo para la matriz de subplots,
%dado un número de subplots que queremos dibujar.
%   INPUTS
%      num_plots: Número de plots que queremos dibujar en una misma matriz
%
%   OUTPUTS
%       num_rows: Número de filas óptimo para subplot
%       num_cols: Número de columnas óptimo para subplot

    if num_plots < 1
        num_rows = 0;
        num_cols = 0;
        return;
    end
    
    num_rows = ceil(sqrt(double(num_plots)));
    num_cols = num_rows;
    while num_rows * (num_cols-1) >= num_plots
        num_cols = num_cols - 1;
    end   
    
end

