function [ tm ] = convertStrToTime( str )
%CONVERTSTRTOTIME Convierte un string de tipo hh:mm:ss en un objeto de tipo
%datetime
%   
% INPUTS
%   str: El string en formato hh:mm:ss
%
% OUTPUTS
%    tm: Un vector de tipo datetime con fecha 01/01/2000 y hora hh:mm:ss
%    especificada en el string str

    yy = 2000;
    mm = 1;
    dd = 1;
        
    s = textscan(str, '%f:%f:%f');

    s1 = s{1};
    s2 = s{2};
    s3 = s{3};

    tm = [yy, mm, dd, s1, s2, s3];


end

