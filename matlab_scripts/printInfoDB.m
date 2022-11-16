
fprintf('Idx\tId\tAge\tSex\tHospital\tClassStr\tClass\tAfectado\n');
for i = 1 : TOTAL_ECG_FILES
    
    
    Sx        = SENYALES{i};
    id        = Sx.id;
    age       = Sx.Info.PatientAge;
    sex       = Sx.Info.PatientSex;
    h_orig    = Sx.Info.HospitalOrigen;
    classStr  = Sx.class_str;
    class     = Sx.class;
    afectado  = Sx.Afectado;
    
    fprintf('%3d\t%s\t%d\t%s\t%s\t%s\t%d\t%d\n', i, id, age, sex, h_orig, classStr, class, afectado);
    
end