function [ table ] = splitIds( ids, delimiter )
%SPLITIDS Summary of this function goes here
%   Detailed explanation goes here


    if nargin < 2
        delimiter = '.';
    end
    
    NI  = length(ids); % N�mero de identificadores
    NG  = 0; % N�mero de grupos
    
    
    % 1 - Contamos el que tenga m�s grupos
    for i = 1 : NI
        aux = length(strsplit(ids{i}, delimiter));
        if aux > NG
            NG = aux;
        end
    end
    
    % 2 - Creamos la tabla
    table = cell(NI, NG);
    
    % 3 - Rellenamos la tabla
    for i = 1 : NI
        aux = strsplit(ids{i}, delimiter);
        for j = 1 : length(aux)
            table{i, j} = aux{j};
        end
    end

end

