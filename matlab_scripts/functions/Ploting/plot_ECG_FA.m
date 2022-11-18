function plot_ECG_FA( ecg, fa, Fs )
%PLOT_ECG_FA Plotea una representación de una senyal de ECG junto con su Fibrilación Auricular (FA)
%
%   INPUTS:
%      ecg: Senyal de Ecg
%       fa: Senyal de Fibrilación Auricular
%       Fs: Frecuencia de Muestreo

    T = getTimeVector(Fs, length(ecg));
    figure;    
    
    subplot(3, 1, 1);
    hold on;
    plot(T, ecg, 'b-');
    plot(T, fa, 'r-');
    title('FA Extraction - ABS');
    xlabel('Time [s]');
    ylabel('Amplitud');
    legend('ecg', 'fa');
    grid;
    hold off    
    
    subplot(3, 1, 2);
    plot(T, ecg, 'b-');
    legend('ECG');        
    xlabel('Time [s].');
    ylabel('Amplitud');     
    legend('ecg');
    grid;

    subplot(3, 1, 3);
    plot(T, fa, 'r-');
    legend('FA (ABS)');
    xlabel('Time [s].');
    ylabel('Amplitud');  
    legend('fa');
    grid;

end

