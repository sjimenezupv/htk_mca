function [ y ] = FiltraPB( x, Fs, Fc )
%FILTRAPB Aplica a la entrada un filtro Paso Bajo
%
% INPUTS
%   x: Vector o Matriz de entrada de tama�o (SAMPLES x CHANNELS)
%  Fs: Frecuencia de Muestreo
%  Fc: Frecuencia de Corte
%
% OUTPUTS
%   y: Vector o Matriz resultado de filtrar con los par�metros de entrada

    [a, b] = creaFiltroPB(Fs, Fc);    
    y  = AplicaFiltFilt(x, a, b);

end

