clear all
close all

%% Wave specifications
Theta = linspace(-90,90,501);  % [degrees] direction of incoming wave from Theta direction
phi = linspace(-90,90,501);  % [degrees] direction of incoming wave from phi direction
    % tip: For phi and theta, use odd-length in linspace, so that phi=0 and
    % theta=0 is in the middle of the array.
f = 2.75E9;  %[Hz] operating frequency
c = 3E8;  %[m/s] speed of light in free space
lambda = c/f;  % [m] wavelength of the incident wave
k_0 = 2*pi/lambda;

%% Antenna specifications
N_x = 50;  % number of elements in the x-direction
N_y = 5;  % number of elements in the y-direction 
N = [N_x, N_y];

d_x = 0.5*lambda; %[m], distance between elements on the x-axis
d_y = 0.5*lambda; %[m], distance between elements on the y-axis
d = [d_x, d_y];

Theta_0 = 40;  % [degrees], direction of optimum sensitivity in the Theta direction
phi_0 = 0;  % [degrees], direction of optimum sensitivity in the phi direction

%  a = uniform_tapering(N);
a = tchebysheff_tapering(N, 20);
S = array_factor(N, d, a, Theta_0, phi_0, k_0, phi, Theta);
[NPRP, PRP] = normalised_power_radiation_pattern(S);




%% Plotting


% plot line at v=0 (fig. 6.16 right figure)
plot(Theta, NPRP(:,ceil(end/2)))
xlim([Theta(1) Theta(end)])
ylim([-50, 1])
grid on
ylabel('Array pattern [dB]')
xlabel('\Theta [deg]')


% %
% for i = 1:length(phi)
%     plot(Theta, NPRP(:,i))
%     xlim([Theta(1) Theta(end)])
%     ylim([-50, 1])
%     grid on
%     ylabel('Array pattern [dB]')
%     xlabel('\Theta [deg]')
%     pause(0.001);   
% end