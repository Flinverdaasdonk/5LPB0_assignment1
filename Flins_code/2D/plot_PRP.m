clear all
close all

load('results/bullet2')


NPRP = NPRP(:,ceil(end/2));  % made a 1D cut
PRP = PRP(:,ceil(end/2));  % made a 1D cut

% sidelobes = findpeaks(PRP)

plot(Theta, PRP)
xlim([Theta(1) Theta(end)])
grid on
hold on
ylim([-20, 50])
ylabel('PRP [dB]')
xlabel('\Theta [deg]')

gain = max(PRP)
[beamwidth, beamwidth_indices] = beamwidth1_D(NPRP, Theta);