function [f_1_0, B] = least_square_pond(found_partials)
% This function uses a least square to compute the inharmonicity B and 
% the fundamental frequency (f_1_0) corresponding to the given partials.
%   found_partials : the computed partials

n = size(found_partials,2);     % number of partials

base = (1:n).';            
C = cat(2, base.^0, base.^2);   % the matrix of C of C*freq = x

freq = (found_partials.').^2./ (base.^2);

x = lsqnonneg(C,freq).';        % return only a positive B value

f_1_0 = sqrt(x(1));
B = x(2)/x(1);


end