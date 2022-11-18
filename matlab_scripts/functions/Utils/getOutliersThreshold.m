function [ threshold_up, threshold_down ] = getOutliersThreshold( x,  num_std)
%GETOUTLIERSTHRESHOLD Calcula los umbrales fuera de los que estarían los
%outliers de los valores de un vector de valores. (num_std desviaciones típicas
%alejados de la mediana, 3 por defecto)
%
% INPUTS
%          x: Vector de valores
%    num_std: Opcional - Número de desviaciones típicas alejado de la mediana para
%                        considerar outlier. 3 por defecto.
%
% OUTPUTS
%     threshold_up: Valor máximo del umbral
%   threshold_down: Valor mínimo del umbral

    if nargin < 2
        num_std = 3;
    end

    % Umbrales para outliers
    m = median(x);
    s = std(x);
    threshold_up   = m + (num_std * s);
    threshold_down = m - (num_std * s); 

end

