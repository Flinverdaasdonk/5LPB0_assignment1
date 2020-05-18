clear all
close all

%% Plotting and saving
plot_1D = 0;
plot_contour = 0;
plot_both = 0;
cheb_SLL = 32; % desired Side lobe level for chebyshev tapering, not used in uniform tapering

save_results = 0; % 0 is no, 1 is yes
save_filename = 'results/bullet3';
%% Wave specifications
angle_steps = 3001;
Theta = linspace(-90,90,angle_steps);  % [degrees] direction of incoming wave from Theta direction
phi = linspace(-90,90,angle_steps);  % [degrees] direction of incoming wave from phi direction
    % tip: For phi and theta, use odd-length in linspace, so that phi=0 and
    % theta=0 is in the middle of the array.
f = 2E9;  %[Hz] operating frequency
c = 3E8;  %[m/s] speed of light in free space
lambda = c/f;  % [m] wavelength of the incident wave
k_0 = 2*pi/lambda;

%% Antenna specifications
N_x = 140;  % number of elements in the x-direction
N_y = 1;  % number of elements in the y-direction 
N = [N_x, N_y];

d_x = 0.625*lambda; %[m], distance between elements on the x-axis
d_y = 0.625*lambda; %[m], distance between elements on the y-axis
d = [d_x, d_y];

Theta_0 = -15;  % [degrees], direction of optimum sensitivity in the Theta direction
phi_0 = 0;  % [degrees], direction of optimum sensitivity in the phi direction

if (length(phi) < 3000 || length(Theta) < 3000)
    warning(["Make sure phi and theta have enough samples, e.g. more than 4000"])
    warning(["This ensures high enough definition in the contour plot"])
end
% a = uniform_tapering(N);
a = tchebysheff_tapering(N, cheb_SLL);

f = element_pattern(N, 0);  % add the element pattern. 0 = all isotropic, 1 = partial half-wavelength dipoles 

S = array_factor(N, d, a, f, Theta_0, phi_0, k_0, phi, Theta);
[NPRP, PRP] = normalised_power_radiation_pattern(S);

if save_results
   save(save_filename) 
end



%% Plotting


if plot_1D
    % plot line at v=0 (fig. 6.16 right figure)
    plot(Theta, NPRP(:,ceil(end/2)))
    xlim([Theta(1) Theta(end)])
    ylim([-50, 1])
    grid on
    ylabel('NPRP [dB]')
    xlabel('\Theta [deg]')
    title("v = 0")

end

if plot_contour
    u = sind(Theta).'*cos(phi);
    v = sind(Theta).'*sin(phi);
    
   contour(u, v, NPRP, [0.8, 0.8]) 
end

if plot_both
    u = sind(Theta).'*cos(phi);
    v = sind(Theta).'*sin(phi);
    subplot(2, 1, 1)
    contour(u, v, NPRP, [-50 -cheb_SLL-15 -cheb_SLL-5 -cheb_SLL -3]) 
    xlabel('u')
    ylabel('v')
    
    subplot(2, 1, 2)
    plot(Theta, NPRP(:,ceil(end/2)))
    xlim([Theta(1) Theta(end)])
    ylim([-50, 1])
    grid on
    ylabel('NPRP [dB]')
    xlabel('\Theta [deg]')
    title("v = 0")
end

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