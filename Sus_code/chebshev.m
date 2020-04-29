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
p=0;
q=0;
for i=1:140
    h=0;
    m=(-(N-1)/2 : (N-1)/2).*dx;
    l=chebwin(140,32);
    beta=2*pi*(i-1)*0.625*u;
    ss=l(i,1)*exp(1j*beta);
    p=p+ss;
    q=q+l(i,1);
end
p=p.^2/q^2;
p=10*log10(p);
plot(theta,p);
xlabel('Angle in [degrees]')
ylabel('Beamformer gain in [dB]')
axis([-90 90 -60 0]);
