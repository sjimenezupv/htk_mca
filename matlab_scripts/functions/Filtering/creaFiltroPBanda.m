
function [a, b] = creaFiltroPBanda(Fs, Fc1, Fc2)


    % Design a bandpass filter with a passband from 60 to 200 Hz with
    % at  most  3 dB of passband ripple and 
    % at least 40 dB attenuation in the stopbands. 
    % Specify a sampling rate of 1 kHz. 
    % Have the stopbands be 50 Hz wide on both sides of the passband. 
    % Find the filter order and cutoff frequencies.
    
     
%     Wp = [Fc1 Fc2]/Fn;
%     Ws = [1 50]/Fn;
%     Rp = 3;
%     Rs = 60;
%     [n, Wn] = buttord(Wp,Ws,Rp,Rs);
%     
%     
%     % Cálcula el filtro.
%     [b, a] = butter(n, Wn, 'bandpass')

    
    rp = 3;
    rs = 60;
    
    if Fc2-Fc1 < 5
        rs = 40;
    end

    Fn    = Fs/2;
    w1    = Fc1/Fn;
    w2    = Fc2/Fn;
     n    = buttord(w1, w2, rp, rs);
    wn    = [w1 w2];
    [b,a] = butter(n, wn, 'bandpass');

end