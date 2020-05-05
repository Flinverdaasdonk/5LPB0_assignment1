clear all
close all

%% Wave specifications
Theta = linspace(-90,90,10000);  % [degrees] direction of incoming wave
f = 2E9;  %[Hz] operating frequency
c = 3E8;  %[m/s] speed of light in free space
lambda = c/f;  % [m] wavelength of the incident wave
k_0 = 2*pi/lambda;

%% Antenna specifications
A1.N_x = 140;  %[-] number of elements in the phased array (i.e. the number of individual antennas)
A1.Theta_0 = -15;  % [degrees] direction of optimum sensitivity
A1.d_x = 0.625*lambda;

% Gratis lobes appear in the radiation pattern when a > 1 in the piece of
% code below:
% a = 1.1;
% A1.d_x = a*(1/(1+abs(sind(A1.Theta_0))))*lambda;  % [m] distance between elemental antennas
% A1.a_k = uniform_tapering(A1.N_x);

%A1.a_k = uniform_tapering(A1.N_x);
A1.a_k = tchebysheff_tapering(140, 32);

A1.S = array_factor(A1.a_k, A1.d_x, A1.Theta_0, k_0, Theta);
[NPRP_dB, gain_dB] = normalised_power_radiation_pattern(A1.S); 
A1.NPRP = NPRP_dB;

[A1.beamwidth, A1.beamwidth_indices] = beamwidth(A1.NPRP, Theta);
disp(["A1: beamwidth = " + num2str(A1.beamwidth)])
disp(["A1: max gain = " + num2str(max(gain_dB))])



%% Plotting
% subplot(2, 1, 1)
% plot(Theta, A1.S)
% grid on
% xlabel('\Theta [degrees]')
% xlim([Theta(1), Theta(end)])
% ylabel('Radiation pattern')
% title("Array factor")
% 
% subplot(2, 1, 2)
plot(Theta, A1.NPRP)
grid on
hold on
plot([Theta(A1.beamwidth_indices(1)), Theta(A1.beamwidth_indices(2))], [A1.NPRP(A1.beamwidth_indices(1)), A1.NPRP(A1.beamwidth_indices(1))]);
xlabel('\Theta [degrees]')
xlim([Theta(1), Theta(end)])
ylim([-50 0])
ylabel('NPRP [dB]')
title("Normalised power radiation pattern ")
foo = strcat('Beamwidth = ', num2str(A1.beamwidth));
legend('NPRP', foo)
