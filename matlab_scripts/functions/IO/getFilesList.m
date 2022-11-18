function [ fileList, numFiles ] = getFilesList( basePath, ext_filter )
%GETFILESLIST Obtiene una lista con los archivos que contiene el directorio especificado
%
% AUTHOR: Santiago Jiménez [sanjiser@upv.es]
% Obtiene una lista con los archivos que contiene el directorio especificado
%
% INPUTS
%  basePath: Ruta al directorio sobre el que listar sus ficheros
%  ext_filter: Opcional - Extensión de los ficheros a listar
%
% OUTPUTS
%  fileList: Lista con el nombre de ficheros en el directorio especificado
%  numFiles: Número de ficheros en la lista anterior

    % Parámetros por defecto
    if nargin < 2, filtro_activado = false;
    else           filtro_activado = true;    end

    fileList = dir(basePath);
    
    
    % Borramos los directorios y los que no cumplen el patrón del filtro    
    i = 1;    
    while i <= length(fileList)
        
        % Borramos Directorios
        if fileList(i).isdir == 1
            fileList(i) = [];
            i = i - 1;
            
        % Borramos los que no tengan la extensión
        elseif filtro_activado == true
            %[~, ~, ext] = fileparts(fileList(i).name);
            %if strcmpi(ext, ext_filter) == 0
            if strendswith(fileList(i).name, ext_filter) == 0
                fileList(i) = [];
                i = i - 1;
            end
        end
        
        i = i + 1;
    end
    
    % Número de ficheros
    numFiles = length(fileList);
end

