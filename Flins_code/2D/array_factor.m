function S = array_factor(inputArg1,inputArg2)
    %ARRAY_FACTOR Takes in antenna parameters, and gives the resulting array
    %factor
    % INPUT
    %    antenna parameters:
    %    N: [N_x, N_y]; number of elements in the x- and y-direction respectively
    %    a: matrix with dimension N_x*N_y; weights for each phased-array elements
    %    d: [d_x, d_y]; distance between elements in the x- and y-direction respectively
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

    u_0 = sind(Theta_0)*cos(phi_0);
    v_0 = sind(Theta_0)*sin(phi_0);
    u = sind(Theta)*cos(phi);
    v = sind(Theta)*sin(phi);
end

