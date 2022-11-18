function [ D ] = getVCGDistance( vcg1, vcg2 )
%GETVCGDISTANCE Calcula la distancie euclidea entre dos VCG del mismo
%tamanyo

    [n1, m1] = size(vcg1);
    [n2, m2] = size(vcg2);
    if m1 ~= 3
        error('vcg1 no tiene 3 coordenadas');
    end
    if m2 ~=3
        error('vcg2 no tiene 3 coordenadas');
    end
    if n1 ~= n2
        error('El tamanyo entre los dos vcg ha de ser igual');
    end
    
    diff = power(vcg1 - vcg2, 2);
    tot  = sum(sum(diff));    
    D    = sqrt(tot);
    
    %D = norm(vcg1-vcg2);

end

