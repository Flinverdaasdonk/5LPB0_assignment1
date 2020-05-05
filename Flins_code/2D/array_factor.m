function S = array_factor(N, d, a, Theta_0, phi_0, k_0, phi, Theta)
    %ARRAY_FACTOR Takes in antenna parameters, and gives the resulting array
    %factor
    % INPUT
    %    antenna parameters:
    %    N: [N_x, N_y]; number of elements in the x- and y-direction respectively
    %    d: [d_x, d_y]; distance between elements in the x- and y-direction respectively
    %    a: matrix with dimension N_x*N_y; weights for each phased-array elements
    %    Theta_0: scalar; optimum angle of reception in the Theta direction
    %    phi_0: scalar; optimum angle of reception in the phi direction
    %    
    %    wave parameters:
    %    k_0: wavenumber of incoming wave
    %    phi: sweep of angles over the phi direction to simulate the incoming wave from lots of angles
    %    Theta: sweep of angles over the Theta direction  to simulate the incoming wave from lots of angles
    %    
    % OUTPUT:
    %     S: matrix: 2D array factor

    
    d_x = d(1);
    d_y = d(2);
    N_x = N(1);
    N_y = N(2);
    
    u_0 = sind(Theta_0)*cosd(phi_0);
    v_0 = sind(Theta_0)*sind(phi_0);
    u = sind(Theta).'*cos(phi);
    
    v = sind(Theta).'*sin(phi);
    
    S = zeros(size(u));  % initialise a matrix
    % implementation of (6.40) from "Modern Antennas and Microwave circuits"
    for u_k = 1:N_x
       % u_k  % print for time tracking purposes
       for v_l = 1:N_y
           pwr = 1i*k_0*((u_k-1)*d_x*(u-u_0) + (v_l-1)*d_y*(v-v_0));
           S_k_l = abs(a(u_k, v_l))*exp(pwr);
           S = S + S_k_l;
       end
    end
    
end

