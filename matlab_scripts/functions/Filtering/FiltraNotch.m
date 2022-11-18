function [ y ] = FiltraNotch( x, Fs, Fc )
%FILTRANOTCH Aplica a la entrada un filtro de tipo Notch
%
% INPUTS
%   x: Vector o Matriz de entrada de tamaño (SAMPLES x CHANNELS)
%  Fs: Frecuencia de Muestreo
%  Fc: Frecuencia de Corte
%
% OUTPUTS
%   y: Vector o Matriz resultado de filtrar con los parámetros de entrada

    [a, b] = creaFiltroNotch(Fs, Fc);    
    y  = AplicaFiltFilt(x, a, b);

end

