function [ y ] = FiltraPA( x, Fs, Fc )
%FILTRAPA Aplica a la entrada un filtro Paso Alto
%
% INPUTS
%   x: Vector o Matriz de entrada de tamaño (SAMPLES x CHANNELS)
%  Fs: Frecuencia de Muestreo
%  Fc: Frecuencia de Corte
%
% OUTPUTS
%   y: Vector o Matriz resultado de filtrar con los parámetros de entrada

    [a, b] = creaFiltroPA(Fs, Fc);    
    y  = AplicaFiltFilt(x, a, b);

end

