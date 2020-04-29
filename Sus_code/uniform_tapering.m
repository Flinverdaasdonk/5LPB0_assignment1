clear all;
close all;
clear classes;
clc;

%% Assign 1
% 1. Setup the ULA settings as in figure 1 of the assignment

N = 140;                  % Number of sensors
c = 3*10^8;
f = 2*10^9;     
dx = 0.625*c/f;      % meters of element spacing in x-direction 
dy =0;               % meters of element spacing in y-direction 

theta=-90:0.1:90;
u0=sind(-15);
u=sind(theta)-u0;

s= (1/N^2)*(abs(sin(N*pi*0.625*u)./sin(pi*0.625*u))).^2;
s1= 10*log10(s); 
plot(theta,s1);
xlabel('Angle in [degrees]')
ylabel('Beamformer gain in [dB]')
axis([-90 90 -60 0]);