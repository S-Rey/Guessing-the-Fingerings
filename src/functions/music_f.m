function p = music_f(v, Fs, f_range)
% Compute the Music pseudospectrum given the noise matrix v, the sampling
% frequency and the range of frequencies
%   v
%   Fs
%   f_range

% Gererate e(f)
w = (2*pi * f_range / Fs);
e = exp((-1i)*w*(0:size(v,1)-1));

squares_a = abs((e*v).^2);

p = sum(squares_a,2).^(-1);

end

