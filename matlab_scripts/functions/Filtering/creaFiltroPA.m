
function [a, b] = creaFiltroPA(Fs, Fc)

%     rp = 3;
%     rs = 60;
    
    rp = 0.5;
    rs = 15;

    Fn = Fs/2;
    
    % Wp > Ws
    Wp = (Fc+5)/Fn;
    Ws = Fc/Fn;  % Para que atenue los 15 db dejamos un margen de 5 Hz
    
    [n, Wn] = buttord(Wp, Ws, rp, rs);
    [b, a]  = butter(n, Wn, 'high');

end