function a = tchebysheff_tapering(N_x,SLL)
    %CHEBYSHEV_TAPERING calculates the element weights necessary to achieve
    %chebyshev tapering, i.e. constant side lobe level (SLL)
    % INPUT
    %     N_x: scalar; number of elements, i.e. weights
    %     SLL: scalar; "side-lobe level", indicates the dB difference between the 
    %         lobe and the side lobes
    %         
    % OUTPUT
    %     a: row_vector; weights for the elements in the phased array
    
    a = chebwin(N_x, SLL);
end

