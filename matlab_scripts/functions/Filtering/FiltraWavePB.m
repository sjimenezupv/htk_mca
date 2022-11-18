function [ y ] = FiltraWavePB ( x , Fs , Fc , wavelet)
%FILTRAWAVEPB Función que realiza el filtrado paso bajo de una señal mediante wavelets
%
% INPUTS:
%   x       -->     Señal a filtrar
%   Fs      -->     Frecuencia de muestreo
%   Fc      -->     Frecuencia de corte deseada
%   wavelet -->     Función wavelet a utilizar (doc wavefun)
%
% OUTPUTS:
%   y       -->     Señal filtrada

    fc=Fs/2;
    lvls=1;
    while fc>Fc
        lvls=lvls+1;
        fc=fc/2;
    end
    [C,L]=wavedec(x,lvls,wavelet);
    y=wrcoef('a',C,L,wavelet,lvls);
    
end