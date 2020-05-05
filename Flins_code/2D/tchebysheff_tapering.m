function a = tchebysheff_tapering(N, SLL)
    %CHEBYSHEV_TAPERING calculates the element weights necessary to achieve
    %chebyshev tapering, i.e. constant side lobe level (SLL)
    % INPUT
    %     N: [N_x, N_y]; number of elements in the x- and y-direction, i.e. the number of required weights
    %     SLL: scalar; "side-lobe level", indicates the dB difference between the 
    %         lobe and the side lobes
    %         
    % OUTPUT
    %     a: row_vector; weights for the elements in the phased array
    
    N_x = N(1);
    N_y = N(2);

    a_x = chebwin(N_x, SLL);
    a_y = chebwin(N_y, SLL);
    % a = a_x*a_y.';
    a = (a_x + a_y.')/2;
end

