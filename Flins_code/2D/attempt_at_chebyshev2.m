% based on the book "phased array antenna handbook" by R.C. Hansen, section
% 3.2

clear all
close all


% trying to reproduce the same results as gotten with
% w = chebwin(L,r) returns an L-point Chebyshev window using sidelobe magnitude factor r dB.

% chebyshevT( order , position on x)
% N = number of elements

% main beam is mapped unto x > 1 in the Chebyshev polynomial
% this is done through x = x_0 cos(u/2)
% u is the pattern variable and given by y = k d sin(Theta)
% This leads to F(u) = T_{N-1}[x_0 cos(u2)]

% for half-wavelength spacing the minimum value of x = 0 (why?)
% maximum element spacing is
% d/lambda = arccos(-1/x0)/pi
% with d = 0.525 lambda the equation above leads to x0 ~~ 12.745
% still no idea what x0 is

%% relevant equations
% (3.9)  d/lambda = arccos(-1/x0)/pi f
% assignment description says d = 0.525 lambda, which in combination with
% ((3.9) leads to x0 = 12.745 

SLR = 2000;  % Hansen uses SLR voltage ratio. Matlabs chebwin function uses 100dB standard. 100dB => 2000v (?) 
N = 6;
x_0 = cosh(acosh(SLR)/(N-1));

A = zeros(1, N);

% This nested loop is (3.9)
for n =1:N
    disp(['n = ', num2str(n)])
    sum = 0;
    for m = 1:N
        cheb_arg = x_0*cos(pi*m/N);
        cheb = chebyshevT(N-1, cheb_arg);
        expo_arg = (2*n-N-1)*pi*m/N;
        expo = exp(-1i*expo_arg);
        sum = sum + cheb*expo;
    end
    A(n) = abs(sum/N);
end
A = A/max(A);  % A on its own is very large, this normalises it. Can't see this step in in Hanson's though

cheb_A = chebwin(N);
dif = A.' - cheb_A