function [ Y ] = Filtra_NaN_Simple( Y )
%FILTRA_NANSIMPLE Filtra, de manera simple, los NaN de una senyal o matriz de senyales.
%   Reemplaza los NaN por los valores no NaN anteriores de la senyal.
%
% INPUTS
%   Y: Vector o Matriz de entrada de tamaño (SAMPLES x CHANNELS)
%
% OUTPUTS
%   Y: Vector o Matriz resultado de filtrar sus valores NaN



    [nsamples, nchannels] = size(Y);
    if nsamples < nchannels
        Y = Y';
    end
    [nsamples, nchannels] = size(Y);    
    END = nsamples;
    
    % Para cada canal
    for c = 1 : nchannels
        
        % Extraemos el canal
        x = Y(:, c);
        
        % Filtramos el primer NaN si existiera
        if isnan(x(1)) && ~isnan(x(2))
            x(1) = x(2);
        end

        % Filtramos los tramos donde sólo haya un NaN en medio de dos valores
        i = 2;
        while i < END
            if isnan(x(i)) && ~isnan(x(i-1)) && ~isnan(x(i+1))
                x(i) = getInterpolacion(x(i-1), x(i+1));
            end
            i = i + 1;
        end

        % Filtramos los tramos donde haya más de una NaN consecutivo
        i = 1;    
        while i <= END
            if isnan(x(i))
                if i ~= 1
                    x(i) = x(i-1);
                else
                    x(i) = 0;
                end
            end
            i = i + 1;
        end
        
        
        % Ponemos el resultado
        Y(:, c) = x;
    
    end

end

