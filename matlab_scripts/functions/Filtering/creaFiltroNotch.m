
function [a, b] = creaFiltroNotch(Fs, Fc)


    Q  = 35;
    Fn = Fs/2;
    
    W0 = Fc/Fn;
    %bw = W0/Q; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    bw = 0.1;
    
    
    [b, a] = iirnotch(W0, bw);

end