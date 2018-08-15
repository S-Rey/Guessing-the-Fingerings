function [Y, indices] = FFT(signal, Fs, varargin)
%Do a FFT on the signal with its indices in Hz
%   signal      : the signal on which the FFT is done
%   Fs          : the sampling frequency of the signal
%---optional-----
%   len_sign    : the lenght on which the FFT will be sone in seconds
%   begin_sign  : the time from which the FFT will be computed

% set up the variable
len_sign = length(signal);
begin_sign = 1;
    
if nargin >= 3
    len_sign = varargin{1};
end

if nargin >= 4
    begin_sign = varargin{2};
end

end_sign = begin_sign + len_sign - 1;

% begin the FFT

Y = abs(fft(signal(begin_sign:end_sign)));
Y = Y(1:floor(len_sign/2 + 1));
indices = [0:Fs/len_sign:Fs/2];
end

