% based on the paper linked below: 
% https://journals.ametsoc.org/doi/full/10.1175/1520-0493%281997%29125%3C0655%3ATDCWAS%3E2.0.CO%3B2


clear all
close all

x = linspace(-1,1,10);
Theta = linspace(-pi, pi, 10);
r = 20;

eq1 = W(Theta, 1, r);
chebwin = chebwin(10)

%% functions
function result = W(Theta, M, r)
    x_0 = cosh((1/(2*M))*acosh(1/r));
    
    arg1 = x_0*cos(Theta/2);
    num = chebyshevT(2*M,arg1);
    denom = chebyshevT(2*M,x_0);
    result = num/denom;
    result = abs(result);
end