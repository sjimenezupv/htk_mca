function [ y ] = FiltraWavePB ( x , Fs , Fc , wavelet)
%FILTRAWAVEPB Funci�n que realiza el filtrado paso bajo de una se�al mediante wavelets
%
% INPUTS:
%   x       -->     Se�al a filtrar
%   Fs      -->     Frecuencia de muestreo
%   Fc      -->     Frecuencia de corte deseada
%   wavelet -->     Funci�n wavelet a utilizar (doc wavefun)
%
% OUTPUTS:
%   y       -->     Se�al filtrada

    fc=Fs/2;
    lvls=1;
    while fc>Fc
        lvls=lvls+1;
        fc=fc/2;
    end
    [C,L]=wavedec(x,lvls,wavelet);
    y=wrcoef('a',C,L,wavelet,lvls);
    
end