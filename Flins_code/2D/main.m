clear all
close all

%% Settings
plot_1D = 0;   % plot 1D PRP, 0 is no, 1 is yes
plot_contour = 0;    % plot contour, 0 is no, 1 is yes 
plot_both = 0;    
cheb_SLL = 32; % desired Side lobe level for chebyshev tapering, not used in uniform tapering
change_f_for_grating_lobe = 0;    % change the frequency of the impeding wave such that grating lobes appear
tapering = 1;   % 0 or 'uniform' is uniform tapering, 1 or 'chebyshev' is chebyshev tapering
save_results = 1; % 0 is no, 1 is yes
save_filename = 'results/bullet4_cheb';
%% Wave specifications
angle_steps = 4001;
Theta = linspace(-90,90,angle_steps);  % [degrees] direction of incoming wave from Theta direction
phi = linspace(-90,90,angle_steps);  % [degrees] direction of incoming wave from phi direction
    % tip: For phi and theta, use odd-length in linspace, so that phi=0 and
    % theta=0 is in the middle of the array.
f = 2.75E9;  %[Hz] operating frequency
c = 3E8;  %[m/s] speed of light in free space

lambda = c/f;  % [m] wavelength of the incident wave
k_0 = 2*pi/lambda;

%% Antenna specifications
N_x = 25;  % number of elements in the x-direction
N_y = 25;  % number of elements in the y-direction 
N = [N_x, N_y];
d_x = 0.525*lambda; %[m], distance between elements on the x-axis
d_y = 0.525*lambda; %[m], distance between elements on the y-axis
d = [d_x, d_y];
Theta_0 = 15;  % [degrees], direction of optimum sensitivity in the Theta direction
phi_0 = 90;  % [degrees], direction of optimum sensitivity in the phi direction

if change_f_for_grating_lobe
    f = c/(d_x*(1 + max(sind(Theta_0), sind(-Theta_0))));  % refine for first grating lobe
    f = f;
    lambda = c/f;  % [m] wavelength of the incident wave
    k_0 = 2*pi/lambda;
end

freq = f;

if (length(phi) < 3000 || length(Theta) < 3000)
    warning(["Make sure phi and theta have enough samples, e.g. more than 4000"])
    warning(["This ensures high enough definition in the contour plot"])
end

if strcmp(tapering, 'uniform') || tapering == 0
    a = uniform_tapering(N);
elseif strcmp(tapering, "chebyshev") || tapering == 1
    a = tchebysheff_tapering(N, cheb_SLL);
end


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
    u = sind(Theta).'*cosd(phi);
    v = sind(Theta).'*sind(phi);
    
   contour(u, v, NPRP, [0.8, 0.8]) 
end

if plot_both
    u = sind(Theta).'*cosd(phi);
    v = sind(Theta).'*sind(phi);
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