function f = element_pattern(N, type)
% ELEMENT_PATTERN Add the element pattern of the phased array elements.
% INPUT: 
%     N: number of elements
%     type: [0, 1]: 0 = isotropic radiators (i.e. all ones)
%                   1 = partial half-wavelength dipoles as described by the assignment
%                   
% OUTPUT: 
%     f: matrix of size N, element pattern

    if type == 0
        f = ones(N);
    elseif type == 1
        f = zeros(N);
    else
        error('type can be either 0 or 1, read function description')
end

