function [ bpm ] = getBPM( rr_interval )
%GETBPM Calculas los bpms según el intervalo RR
%
% INPUTS
%    rr_interval: Intevalo R-R, en segundos
% 
% OUTPUTS
%   bpm: Beats per minut. Latidos por minuto

    bpm = 60 / rr_interval;
end

