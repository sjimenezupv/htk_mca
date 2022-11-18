function [ T ] = createRawDataTable( DATA, DATA_COL_NAMES, RowIds )
%CREATERAWDATATABLE Summary of this function goes here
%   Detailed explanation goes here


    % Variables Locales
    [N_SAMPLES, N_COLS] = size(DATA);
    [N_COLNAMES]        = length(DATA_COL_NAMES);
    [N_ROWIDS]          = length(RowIds);
    
    % Test for Errors
    if N_SAMPLES ~= N_ROWIDS
        error('createRawDataTable :: N_SAMPLES ~= N_ROWIDS');
    end
    if N_COLS ~= N_COLNAMES
        error('createRawDataTable :: N_COLS ~= N_COLNAMES');
    end
    
    % Tabla con los Ids divididos en grupos
    TableIds = splitIds(RowIds);
    
    % Número de columnas que ocupan los grupos de Ids
    [~, N_IDS]   = size(TableIds);
    
    % Número total de columnas de la tabla final
    NC = N_IDS+N_COLS;
    
    % Tabla de datos final
    TABLE = cell(N_SAMPLES, NC);
    
    
    % Rellenamos los nombres de los grupos
    IDS_COL_NAMES    = cell(N_IDS, 1);
    IDS_COL_NAMES{1} = 'ID';
    for i = 2 : N_IDS
        IDS_COL_NAMES{i} = strcat('G', num2str(i-1));
    end
    
    
    % Cell con todos los nombres de las columnas
    COL_NAMES = joinCellArrays( IDS_COL_NAMES, DATA_COL_NAMES );
    
    
    % Rellenamos la tabla de datos
    for r = 1 : N_SAMPLES
        for c = 1 : N_IDS
            TABLE{r, c} = TableIds{r, c};            
        end
        
        idx = N_IDS+1;
        for c = 1 : N_COLS            
            TABLE{r, idx} = DATA(r, c);
            idx = idx+1;
        end
    end
    
    
    
    T = cell2table(TABLE, 'VariableNames', COL_NAMES, 'RowNames', RowIds);
end

