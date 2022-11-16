
clear all;
clc;

% Generamos todas las estructuras de los directorios a recorrer
Genera_ECG_DIR_INFO_DB;

% Inicialización de la estructura
SENYALES = cell(TOTAL_ECG_FILES, 1);
idx      = 1;


for i = 1 : NUM_ECG_DIR_INFO
    
    DIR_INFO = ECG_DIR_INFO_DB{i};
    
    for j = 1 : DIR_INFO.NUM_FILES

        file_name = [DIR_INFO.DIR, DIR_INFO.files(j).name];
        [~,   id] = fileparts(file_name);

        Sx = {};
        
        [ Sx.Y, Sx.Fs, ~, years, sex ] = readPhilipsXML(file_name);
        Sx.Y(end-499:end, :) = [];            % Quitamos la recta de calibrado
        Sx.Y                 = Sx.Y .* 0.005; % Pasamos a mV (Resolución de los .xml de La Fe)
        Sx.Info.FileId       = id;
        Sx.Info.PatientId    = id;
        Sx.Info.PatientAge   = years;
        Sx.Info.PatientSex   = sex;
        Sx.file_name         = file_name;
        Sx.id                = id;
        
        % Artifacted signal in V1
        if (strcmp(Sx.id, '1708683')==1)
            Sx.Y(1:1900, 7) = 0; % Remove the artifact
        end

        
        % Filtramos
        Sx.YFiltrada = Filtra_MCA( Sx.Y, Sx.Fs, false );
        
        % Filtramos (ORIGINAL CASEIB2016) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %Sx.YFiltrada = FiltraNotch( Sx.Y,         Sx.Fs, 50 );
        %Sx.YFiltrada = FiltraPBanda(Sx.YFiltrada, Sx.Fs, 1, 45);
        % Quitamos el transitorio del filtro (0.5 segundos)
        %Sx.YFiltrada(1:250, :)       = [];
        %Sx.YFiltrada(end-249:end, :) = [];
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        
        % Info
        Sx.class_str            = DIR_INFO.CLASS_STR;
        Sx.class                = DIR_INFO.CLASS;
        Sx.Afectado             = DIR_INFO.AFECTADO;
        Sx.Info.HospitalOrigen  = DIR_INFO.HOSPITAL_ORIGEN;
        Sx.Info.IsXmlFormat     = DIR_INFO.IS_XML_FORMAT;
        
        % Set the value to the DB
        SENYALES{idx} = Sx;
        idx           = idx+1;
    end
    
end

InitTable;
printInfoDB;