function [ x, index_filter ] = Filtra_Outliers( x,  num_std )
%FILTRA_OUTLIERS Filtra los outliers del vector de entrada
% Calcula los umbrales fuera de los que estar�an los outliers de los 
% valores de un vector de valores. (num_std desviaciones  t�picas alejados 
% de la mediana, 3 por defecto). A continuaci�n filtra los valores de x 
% considerados outliers.
%
% INPUTS
%          x: Vector o Matriz de valores de tama�o NUM_SAMPLES X NUM_CHANNELS (Filtra por columnas)
%    num_std: Opcional - N�mero de desviaciones t�picas alejado de la mediana para considerar outlier. 3 por defecto.
%
% OUTPUTS
%          x: Vector x con sus outliers filtrados
%   index_filter: Vector de �ndices donde se ha filtrado en x.

    if nargin < 2
        num_std = 3;
    end

    [umb_up, umb_dn] = getOutliersThreshold(x, num_std);
    
    if nargout == 1
        x(x < umb_dn | x>umb_up) = [];
    elseif nargout == 2
        index_filter = find(x < umb_dn | x>umb_up);
        x(index_filter) = [];
    end

end

