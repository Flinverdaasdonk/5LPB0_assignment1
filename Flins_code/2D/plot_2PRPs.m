clear all
close all

load('results/bullet3a_grating')

NPRP_a = NPRP(:,ceil(end/2));  % made a 1D cut
PRP_a = PRP(:,ceil(end/2));  % made a 1D cut


load('results/bullet3b_grating')

NPRP_b = NPRP(:,ceil(end/2));  % made a 1D cut
PRP_b = PRP(:,ceil(end/2));  % made a 1D cut
% sidelobes = findpeaks(PRP)

plot(Theta, PRP_b)
hold on 
plot(Theta, PRP_a)
xlim([Theta(1) Theta(end)])
grid on
hold on
ylim([-20, 50])
ylabel('PRP [dB]')
xlabel('\Theta [deg]')
legend('Uniform tapering', 'Chebyshev tapering')

gain = max(PRP)
[beamwidth, beamwidth_indices] = beamwidth1_D(NPRP, Theta);