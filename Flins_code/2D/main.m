clear all
close all

%% Wave specifications
Theta = linspace(-90,90,10000);  % [degrees] direction of incoming wave from Theta direction
phi = linspace(-90,90,10000);  % [degrees] direction of incoming wave from phi direction
f = 2.75E9;  %[Hz] operating frequency
c = 3E8;  %[m/s] speed of light in free space
lambda = c/f;  % [m] wavelength of the incident wave
k_0 = 2*pi/lambda;

%% Antenna specifications
N = [25, 25]; % number of elements in the [x, y] direction
d_x = 0.525*lambda; %[m], distance between elements on the x-axis
d_y = 0.525*lambda; %[m], distance between elements on the y-axis
d = [d_x, d_y];

Theta_0 = 15;  % [degrees], direction of optimum sensitivity in the Theta direction
phi_0 = 90;  % [degrees], direction of optimum sensitivity in the phi direction

a = uniform_tapering(N);

% TODO: Finish implementing 6.40, try to get figure 6.16