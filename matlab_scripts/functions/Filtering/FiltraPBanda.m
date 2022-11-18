function [ y ] = FiltraPBanda( x, Fs, Fc1, Fc2 )
%FILTRAPBANDA Aplica a la entrada un filtro Pasa Banda
%
% INPUTS
%    x: Vector o Matriz de entrada de tamaño (SAMPLES x CHANNELS)
%   Fs: Frecuencia de Muestreo
%  Fc1: Frecuencia de Corte 1
%  Fc2: Frecuencia de Corte 2
%
% OUTPUTS
%   y: Vector o Matriz resultado de filtrar con los parámetros de entrada


    [a, b] = creaFiltroPBanda(Fs, Fc1, Fc2);    
    y  = AplicaFiltFilt(x, a, b);

end

