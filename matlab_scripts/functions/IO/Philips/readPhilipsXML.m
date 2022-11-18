function [ Y, Fs, ID, years, sex ] = readPhilipsXML( xmlPath, save_mat_flag )
%READPHILIPSXML Lee un Fichero ECG en formato XML de Philips. Guarda una
%copia en .mat en el mismo directorio.
% 
% INPUTS
%        xmlPath: Path al fichero XML
%        save_mat_flag: (Default: true) Flag Indicando si generar el
%        fichero .mat correspondiente al XML en caso que no exista, para
%        posteriores lecturas más rápidas.
%
% OUTPUTS
%       Y : Matriz de N_MUESTRAS X N_CANALES con los datos originales del
%       fichero XML.
%       Fs: Frecuencia de Muestreo
%       ID: Nombre del Fichero (sin la extensión ni el directorio).

    % Parámetros por Defecto
    if nargin < 2
        save_mat_flag = true;
    end

    % Identificador del Fichero
    [~, ID] = fileparts(xmlPath);    
    
    % Leemos el XML %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    matPath = strrep(xmlPath, '.xml', '.mat');
    if ~exist(matPath, 'file')
        [Y, Fs, years, sex] = leer_ECG_XML(xmlPath);

        if save_mat_flag == true
            save(matPath, 'ID', 'Fs', 'Y', 'years', 'sex');
        end
        
    else
        S     = load(matPath);
        Y     = S.Y;
        Fs    = S.Fs;
        years = S.years;
        sex   = S.sex;
    end
        

end

