% Genera las estructuras que contienen información relativa a los
% directorios que contienen los ficheros ECG, junto con sus datos asociados



DIRS = { ...
    'E:/000_Tesis_2022/MCA/data/PACIENTES.biV/', ...
    'E:/000_Tesis_2022/MCA/data/PACIENTES.VI/', ...
    'E:/000_Tesis_2022/MCA/data/CONTROLES.MCA/',  ...
};

CLASES_STR = { ...
    'PACIENTES.biV', ...
    'PACIENTES.VI', ...
    'CONTROLES.MCA', ...
};

CLASES = [ ...    
    1, ...
    2, ...
    6, ...
];


NUM_ECG_DIR_INFO = length(DIRS);
ECG_DIR_INFO_DB  = cell(NUM_ECG_DIR_INFO, 1);
TOTAL_ECG_FILES = 0;

for i = 1 : NUM_ECG_DIR_INFO
    ECG_DIR_INFO           = {};
    ECG_DIR_INFO.DIR       = DIRS{i};
    ECG_DIR_INFO.CLASS_STR = CLASES_STR{i};
    ECG_DIR_INFO.CLASS     = CLASES(i);
    ECG_DIR_INFO.AFECTADO  = CLASES(i) < 5 ;
    ECG_DIR_INFO.HOSPITAL_ORIGEN = 'LAFE';
    ECG_DIR_INFO.IS_MAT_FORMAT   = false;
    ECG_DIR_INFO.IS_XML_FORMAT   = true;
    [ECG_DIR_INFO.files, ECG_DIR_INFO.NUM_FILES] = getFilesList(DIRS{i}, '.xml');
    
    ECG_DIR_INFO_DB{i} = ECG_DIR_INFO;
    TOTAL_ECG_FILES = TOTAL_ECG_FILES + ECG_DIR_INFO.NUM_FILES;
end

clear CLASES CLASES_STR DIRS ECG_DIR_INFO i
