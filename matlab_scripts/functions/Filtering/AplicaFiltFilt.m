function [ y ] = AplicaFiltFilt( x, a, b )
%APLICAFILTFILT Aplica a la entrada el filtro especificado en los coeficientes
%
% INPUTS
%    x: Vector o Matriz de entrada de tamaño (SAMPLES x CHANNELS)
%    a: Coeficientes a del filtro
%    b: Coeficientes b del filtro
%
% OUTPUTS
%   y: Vector o Matriz resultado de filtrar con los parámetros de entrada


    [ x, ~, nchannels ] = AssertMatrixSize( x );
    y = zeros(size(x));
    
    for i = 1 : nchannels
        y(:, i) = filtfilt(b, a, x(:, i));
    end

end

