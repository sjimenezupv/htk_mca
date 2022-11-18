
Id             = cell(TOTAL_ECG_FILES, 1);
FileId         = cell(TOTAL_ECG_FILES, 1);
PatientId      = cell(TOTAL_ECG_FILES, 1);
Years          = cell(TOTAL_ECG_FILES, 1);
Sex            = cell(TOTAL_ECG_FILES, 1);
HospitalOrigen = cell(TOTAL_ECG_FILES, 1);
class_str      = cell(TOTAL_ECG_FILES, 1);
class          = cell(TOTAL_ECG_FILES, 1);
Afectado       = cell(TOTAL_ECG_FILES, 1);

for i = 1 : TOTAL_ECG_FILES
        
    Sx                = SENYALES{i};
    Id{i}             = Sx.id;
    FileId{i}         = Sx.Info.FileId;
    PatientId{i}      = Sx.Info.PatientId;
    Years{i}          = Sx.Info.PatientAge;
    Sex{i}            = Sx.Info.PatientSex;
    HospitalOrigen{i} = Sx.Info.HospitalOrigen;
    class_str{i}      = Sx.class_str;
    class{i}          = Sx.class;
    Afectado{i}       = Sx.Afectado;    
    
end

MCA_T = table(    ...
            Id, ...
            FileId, ...
            PatientId, ...
            Years, ...
            Sex, ...
            HospitalOrigen, ...
            class_str, ...
            class, ...
            Afectado ...
);