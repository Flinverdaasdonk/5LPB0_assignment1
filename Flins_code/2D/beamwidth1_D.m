function [beamwidth, beamwidth_indices] = beamwidth1_D(NPRP, Theta)
    %BEAMWIDTH: Takes in the NPRP (in dB), and the range of the antenna (Theta)
    %to find the beamwidth, i.e. the range of degrees between
    % INPUT
    %     NPRP: row_vector; the normalised power radiation pattern in dB
    %     Theta: row_vector; the range over which the NPRP is calculated
    % OUTPUT
    %     beamwidth: scalar; the beamwidth of the input antenna
    
    index_of_max = find(NPRP == max(NPRP));  % find index of highest NPRP
    index_of_max = index_of_max(ceil(end/2));  % in case several indices have the highest value, pick only one.
    
    
    upper_index = length(NPRP);  % if no upper_index is found, take the highest index in the array
    for i = index_of_max:length(NPRP)
        % loop over the NPRP incrementally to find upper limit
       if NPRP(i) < -3  % when the current NPRP is below -3dB
           upper_index = i;  % store the current i (upper limit of beamwidth)
           break 
       end    
    end
    
    lower_index = 1;  % if no lower_index is found, take the lowest index in the array
    for i = index_of_max:-1:1
       % loop over NPRP decrementally to find lower limit
       if NPRP(i) < -3  % when the current NPRP is below -3dB
           lower_index = i; % store the current i (lower limit of beamwidth)
           break
       end
    end
    
    beamwidth_indices = [lower_index, upper_index];
    beamwidth = Theta(upper_index) - Theta(lower_index); 
end

