function [S] = radiation_pattern_with_uniform_tapering(N_x, k_0, d_x, Theta, Theta_0)
    % OBSOLETE: USE "array_factor.m"
    % Function calculating the radiation pattern from relevant input
    % parameters, assuming uniform tapering
    % INPUT:
    %      N_x: scalar, Number of elements in the array
    %      k_0: scalar, wave number of incident wave
    %      d_x: scalar, Distance between elements (assumed to be uniform)
    %      Theta: array, Range of the radiation pattern, per element of the array, 
    %         it is the direction in which the phased array is most sensitive
    %      Theta_0: scalar, direction of the incident wave
    % OUTPUT:
    %       S: array, the radiation pattern of the range specified by Theta
    % In TeX the radiation pattern for uniform 
    
    
    u_0 = sind(Theta_0);
    u = sind(Theta);
    p1 = exp(1i*(N_x - 1)*k_0*d_x*(u-u_0)/2);
    p2 = ((sind(N_x*k_0*d_x*(u-u_0))/2)./(sind(k_0*d_x*(u-u_0))/2));
    S = p1.*p2
end

