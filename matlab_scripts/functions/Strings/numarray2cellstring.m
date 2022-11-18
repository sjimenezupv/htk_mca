function c = numarray2cellstring(a)
%NUMARRAY2CELLSTRING c=numarray2cellstring(a)
%     Convierte un vector de números en un vector de celdas con strings.
%
% INPUT
%  a - vector of number ,e.g. [1 2 3 4.5];
%
% OUTPUT
%  c - cell with string representation of the number is input array.
%
% EXAMPLE
%  a=[1 2 4 6 -12];
%  c=numarray2cellstring(a);
%  c =
%      '1' '2' '4' '6' '-12'
%

    c={};
    for i=1:length(a)
        c{end+1}=num2str(a(i));
    end
end
