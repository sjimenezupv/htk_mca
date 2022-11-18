function [ x, filtro ] = Filtra_Enventanado( x )
%FILTRA_OUTLIERS Filtra los outliers del vector de entrada
% Calcula los umbrales fuera de los que estarían los outliers de los 
% valores de un vector de valores. (num_std desviaciones  típicas alejados 
% de la mediana, 3 por defecto). A continuación filtra los valores de x 
% considerados outliers.
%
% INPUTS
%          x: Vector o Matriz de valores de tamaño NUM_SAMPLES X NUM_CHANNELS (Filtra por columnas)
%    num_std: Opcional - Número de desviaciones típicas alejado de la mediana para considerar outlier. 3 por defecto.
%
% OUTPUTS
%          x: Vector x con sus outliers filtrados
%   index_filter: Vector de índices donde se ha filtrado en x.


    
    filtro = zeros(size(x));
    
    dev_factor = 1.5;
    err_factor = 1.5;
    
    n        = length(x);
    win      = 10;
    buffer   = Filtra_Outliers(x(1 : win), dev_factor);
    avg      = mean(buffer);
    dev      = std(buffer) * dev_factor;
    
    
    win      = 10;
    buffer   = x(1 : win);
    buffer_i = 1;
    
    
    
    for i = 1 : n
        
        v = x(i);
        
        if v < avg-dev-err_factor || v > avg+dev+err_factor
            filtro(i) = 1;
        else
            buffer(buffer_i) = v;
            buffer_i = buffer_i + 1;
            
            avg      = mean(buffer);
            dev      = std(buffer) * dev_factor;
            
            if buffer_i > win
                buffer_i = 1;
            end
            
        end
        
    end
    
    filtro = find(filtro==1);
    x(filtro) = [];

end

