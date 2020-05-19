clear all
close all

load('results/bullet4_cheb')

u = sind(Theta).'*cosd(phi);
v = sind(Theta).'*sind(phi);

gain = max(max(NPRP));
Levels = gain-100:10:gain-10;
Levels = [Levels gain-3];
% contour1 = gain-40;
% contour2 = gain-20;
% contour3 = gain-3;
% Levels = [contour1, contour2, contour3];

u_0 = sind(Theta_0)*cosd(phi_0);
v_0 = sind(Theta_0)*sind(phi_0);
contour(u, v, NPRP, Levels) 
xlabel('u')
ylabel('v')

disp('done')