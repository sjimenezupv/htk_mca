function [ y ] = FiltraPB( x, Fs, Fc )
%FILTRAPB Aplica a la entrada un filtro Paso Bajo
%
% INPUTS
%   x: Vector o Matriz de entrada de tamaño (SAMPLES x CHANNELS)
%  Fs: Frecuencia de Muestreo
%  Fc: Frecuencia de Corte
%
% OUTPUTS
%   y: Vector o Matriz resultado de filtrar con los parámetros de entrada

    [a, b] = creaFiltroPB(Fs, Fc);    
    y  = AplicaFiltFilt(x, a, b);

end

