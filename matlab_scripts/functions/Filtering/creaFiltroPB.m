
function [a, b] = creaFiltroPB(Fs, Fc)

    Rp = 0.5; % Db de atenuación en la banda que pasa
    Rs = 15;  % Db de atenuación en la stopband

    Fn = Fs/2;
    
    % Wp < Ws
    Wp = Fc/Fn;
    Ws = (Fc+5)/Fn;  % Para que atenue los 15 db dejamos un margen de 5 Hz
    
    [n, Wn] = buttord(Wp, Ws, Rp, Rs);
    [b, a] = butter(n, Wn);%, 'low');

end