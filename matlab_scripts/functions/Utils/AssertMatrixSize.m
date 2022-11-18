function [ M, nsamples, nvars ] = AssertMatrixSize( M )
%ASSERTMATRIXSIZE Asegura que el tamanyo de la matriz de datos sea de tipo Filas=Muestras, Columnas=Variables o Canales de las senyales
%
% INPUTS
%    M: Matriz o Vector de datos
%
% OUTPUTS
%          M: Matriz o Vector de datos en formato Filas=Muestras, Columnas=Variables o Canales de las senyales
%   nsamples: N�mero de muestras (FILAS)
%      nvars: N�mero de variables o canales de las senyales (COLUMNAS)

    [nsamples, nvars] = size(M);
    if nsamples < nvars
        M = M';
        [nsamples, nvars] = size(M);
    end

end

