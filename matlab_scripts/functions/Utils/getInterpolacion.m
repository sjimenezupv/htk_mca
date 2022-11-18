function [ y ] = getInterpolacion( y1, y2 )
%GETINTERPOLACION Devuelve la interpolación simple de dos puntos

    y = y1 + ((y2-y1)/2);

end

