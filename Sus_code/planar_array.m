clear all;
close all;
clear classes;
clc;

%% Assign 1
% 1. Setup the ULA settings as in figure 1 of the assignment

K = 8;
L = 8;                  % Number of sensors
c = 3*10^8;
f = 2.75*10^9;     
dx = 0.525*c/f;      % meters of element spacing in x-direction 
dy =0.525*c/f;               % meters of element spacing in y-direction 
th = -90:0.1:90;
ph = -90:0.1:90;
th0 = 15;
ph0 = 90;
u=sind(th).*cosd(ph);
v=sind(th).*sind(ph);
u0=sind(th0)*cosd(ph0);
v0=sind(th0)*sind(ph0);
% beta=exp(1j*7*pi*0.5*(u-u0)).*exp(1j*7*pi*0.5*(v-v0));
% s=abs(sin(K*pi*(u-u0)/2)./sin(pi*(u-u0)/2)).*abs(sin(L*pi*(v-v0)/2)./sin(pi*(v-v0)/2));
% s=s.^2./4096;
% s1= 10*log10(s); 
% plot(th,s1);
% axis([-90 90 -50 0]); 
m=0;
n=0;
for k=1:25
    beta1=2*pi*(k-1)*0.525*[1,0]'*(u-u0);
    s1=exp(1j*beta1);
    m=m+s1;
end
for l=1:25
    beta2=2*pi*(l-1)*0.525*[0,1]'*(v-v0);
    s2=exp(1j*beta2);
    n=n+s2;
end
s=abs(m.*n)./625;
p= 20*log10(s);
plot(th,p);
axis([-90 90 -50 0]); 