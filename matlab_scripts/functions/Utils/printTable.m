function printTable( M, table_tit, rowLabels, colLabels, umbral_up, umbral_dn, FID, numberFormat, colHdFormat, rowHdFormat )
%PRINTTABLE Imprime los valores de una matriz en formato tabulado
%   
% INPUTS:
%              M: Matriz con los valores a imprimir
%      table_tit: Opcional (Default='')    Título de la tabla
%      rowLabels: Opcional (Default=empty) Nombre para cada fila
%      colLabels: Opcional (Default=empty) Nombre de cada columna
%      umbral_up: Opcional (Default=Inf)   Umbral máximo de los valores a imprimir
%      umbral_dn: Opcional (Default=-Inf)  Umbral mínimo de los valores a imprimir
%            FID: Opcional (Default=1)     File IDentifier, por si queremos imprimir en un archivo
%   numberFormat: Opcional (Default='%f')  Formato de los número a imprimir


    % Valores por defecto
    if nargin < 2; table_tit    =   []; end;
    if nargin < 3; rowLabels    =   []; end;
    if nargin < 4; colLabels    =   []; end;
    if nargin < 5; umbral_up    =  Inf; end;
    if nargin < 6; umbral_dn    = -Inf; end;
    if nargin < 7; FID          =    1; end;
    if nargin < 8; numberFormat = '%f\t'; end;
    if nargin < 9; colHdFormat  = '%s\t'; end;
    if nargin < 10; rowHdFormat = '%s\t'; end;
    
    if isempty(table_tit); imprimeTit = false; else imprimeTit = true; end;
    if isempty(rowLabels); imprimeRHd = false; else imprimeRHd = true; end;
    if isempty(colLabels); imprimeCHd = false; else imprimeCHd = true; end;
    
    if imprimeTit == true
        fprintf(FID, '%s\n', table_tit);
    end
    
    [nrows, ncols] = size(M);
    fmt = numberFormat;
    
    if imprimeRHd == true
        max_rlbl_length = 0;        
        for i = 1 : length(rowLabels)
            if length(rowLabels{i}) > max_rlbl_length
                max_rlbl_length = length(rowLabels{i});
            end
        end
        max_rlbl_length = num2str(max_rlbl_length+4, '%d');
        rowHdFormat     = strcat('%-', max_rlbl_length, 's');
    end
    
    % Imprimimos el nombre de las columnas
    if imprimeCHd == true        
        if imprimeRHd == true
            ESPACIO = ' ';
            fprintf(FID, rowHdFormat, ESPACIO);
        end        
        for i=1:ncols            
            fprintf(FID, colHdFormat, colLabels{i});
        end
        fprintf(FID, '\n');        
    end
    
    
    % Imprimimos la matriz con los valores
    str_out = '*';
    for r=1 : nrows
        
        if imprimeRHd == true
            fprintf(FID, rowHdFormat, rowLabels{r});
        end
        
        for c=1 : ncols
            
            value = M(r, c);
            if value >= umbral_dn && value <= umbral_up
                fprintf(FID, fmt, value);
            else
                fprintf(FID, '%18s', str_out);
            end
        end
        
        fprintf(FID, '\n');
    end
    fprintf('\n');
end