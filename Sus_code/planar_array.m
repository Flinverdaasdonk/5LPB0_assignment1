clear all;
close all;
clear classes;
clc;

%% Assign 1
% 1. Setup the ULA settings as in figure 1 of the assignment

K = 25;
L = 25;                  % Number of sensors
c = 3*10^8;
f = 2.75*10^9;     
dx = 0.525*c/f;      % meters of element spacing in x-direction 
dy =0.525*c/f;               % meters of element spacing in y-direction 
th = -90:0.5:90;
ph = -90:0.5:90;
[ph,th]=meshgrid(ph,th); 
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
m1=0;
n=0;
n1=0;
for k=1:25
    beta1=2*pi*(k-1)*0.525*(u-u0);
    c1=chebwin(25,32);
    s1=c1(k,1)*exp(1j*beta1);
    s11=exp(1j*beta1);
    m=m+s1;
    m1=m1+s11;
end
for l=1:25
    beta2=2*pi*(l-1)*0.525*(v-v0);
    c2=chebwin(25,32);
    s2=c2(l,1)*exp(1j*beta2);
    s21=exp(1j*beta2);
    n=n+s2;
    n1=n1+s21;
end
s=abs(m.*n).^2/max(abs(m.*n).^2);
p= 10*log10(s);
plot(th,p)%,"--");
% hold on
% ss=abs(m1.*n1).^2/max(abs(m1.*n1).^2);
% pp= 10*log10(ss);
% plot(th,pp);
axis([-90 90 -60 0]); grid on

%legend("chebyshev tapering","uniform tapering");