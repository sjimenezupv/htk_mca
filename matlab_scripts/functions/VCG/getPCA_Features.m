function [ S ] = getPCA_Features( Y )
%GETPCA_FEATURES Summary of this function goes here
%   Detailed explanation goes here





    %[C,S,L2] = pca(Y');    
    %[C,S,L2] = pca(Y');
    
    [C, PC, EigV] = pca(Y');
    %[~, ~, EigV] = pca(Y');
    
    %S(1) = sum(EigV);
    %S(1) = sum(EigV(1))/sum(EigV);
    %plot(C(:, 1));
    
    S(1) = sum(EigV(1:2))/sum(EigV(1:8));
    S(2) = sum(EigV(1:3))/sum(EigV(1:8));
    S(3) = sum(EigV(4:8))/sum(EigV(1:8));
    S(4) = sum(EigV(3))/sum(EigV(1:2));    
    S(5) = sum(EigV(4))/sum(EigV(1:3)); 
    
    return;
    
    %size(C)
    %size(PC)
    
   [qrsV5] = getQRS(C(:, 1), 500, false); % Escalamos en función del pico R más elevado (se habrán filtrado los outliers, ectópicos, ...)

    

    
    % Creamos el patrón para cada derivación según las ondas R en V5
    PatronesR = cell(1, 12);
    for j=1:11    
        ecg = C(:, j);
        
        patron = getQRS_Pattern3( ecg, 500,  80, false, qrsV5 ); % Patrones onda R (60 ms?)
        
        PatronesR{j} = patron;
        
        
        %subplot(3, 4, j);
        %plot(patron)
        %pause;
    end  
    
    EcgPatronR      = cell2mat(PatronesR);
    S           = getVCG_Features( EcgPatronR ); 
    
    %S = EigV(1:5);
    
    size(EigV);


end

