function [NPRP_dB, PRP_dB] = normalised_power_radiation_pattern(S)
    %NORMALISED_POWER_RADIATION_PATTERN Takes in the radiation pattern and
    %turns this into the normalised power radiation pattern (NPRP)
    % INPUT
    %   S: row_vector, the radiation pattern of an antenna
    % OUTPUT
    %   NPRP: row_vector, the normalised power radiation pattern of that same
    %   antenna
    %   NPRP_dB: row_vector, same as NPRP, only in dB

    % See equation 6.12 from the book "Modern Antennas and Microwave
    % Circuits". In TeW, NPRP is given by:
    % \frac{|S(u)|^2}{|S(u)|_{max}^2}
    
    p1 = abs(S).^2;
    PRP_dB = 10*log10(p1);
    
    p2 = max(p1);
    NPRP = p1/p2;
    NPRP_dB = 10*log10(NPRP);  % convert NPRP to dB
end

