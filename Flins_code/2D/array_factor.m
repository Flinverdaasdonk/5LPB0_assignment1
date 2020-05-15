function S = array_factor(N, d, a, f, Theta_0, phi_0, k_0, phi, Theta)
    %ARRAY_FACTOR Takes in antenna parameters, and gives the resulting array
    %factor
    % INPUT
    %    antenna parameters:
    %    N: [N_x, N_y]; number of elements in the x- and y-direction respectively
    %    d: [d_x, d_y]; distance between elements in the x- and y-direction respectively
    %    a: matrix with dimension N_x*N_y; weights for each phased-array elements
    %    f: matrix with size(N); element pattern for each element
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
    K = N_x;
    N_y = N(2);
    L_ = N_y;
    
    u_0 = sind(Theta_0)*cosd(phi_0);  % convert to u-coordinates
    v_0 = sind(Theta_0)*sind(phi_0);
    u = sind(Theta).'*cos(phi);  % (6.37) 
    v = sind(Theta).'*sin(phi); % (6.37)
      
  

    S = zeros(size(u));  % initialise a matrix
    % implementation of (6.40) from "Modern Antennas and Microwave circuits"
    for k = 1:K  % sum over all elements in the x-direction
       for L = 1:L_  % sum over all elements in the y-direction
           
           % the argument in the exponent in (6.40)
           pwr = 1i*k_0*((k-1)*d_x*(u-u_0) + (L-1)*d_y*(v-v_0)); 
           
           % the part of the equation inside the summations
           S_k_L = abs(a(k, L))*f(k, L)*exp(pwr);       
           S = S + S_k_L;
       end
    end
    
end

