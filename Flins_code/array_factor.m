function S = array_factor(a_k, psi_k, d_x, Theta_0, k_0, Theta)
    %RADIATION_PATTERN : general radiation pattern for 1D antennas array. Uses the elemental antenna
    %parameters and wave characteristics to find the radiation pattern.
    % INPUT
    %     antenna parameters:
    %     a_k: row_vector; the complex amplitude scaling of all elemental antennas
    %     psi_k: row_vector; the phase shift introduced by all elemental antennas
    %     d_x: scalar; distance between each element. Assumed to be uniform
    %     Theta_0: scalar; angle between the normal and the direction of maximum sensitivity
    %     
    %     wave parameters:
    %     k_0: scalar, wavenumber of the incident wave
    %     Theta: row_vector, direction of incoming wave compared to the normal.
    % OUTPUT
    %     S: row_vector, the radiation pattern
    
    % Check if input format is correct
    if length(a_k) == length(psi_k)
       K = length(a_k); 
    else
        error('Error: a_k and psi_k are not of the same length')
    end
    
    u_0 = sind(Theta_0);  % to declutter the equations to come. See eq. 6.5 from the book 
    u = sind(Theta);
    S = zeros(1, length(Theta));  % allocate space for the radiation pattern 
    for k = 1:K
        a = a_k(k);
        pwr = 1i*(k_0*(k-1)*d_x*(u-u_0));  % goes inside the exponential
        S_k = abs(a)*exp(pwr);  % see eq. 6.6
        S = S + S_k;  % see eq. 6.6
    end
end

