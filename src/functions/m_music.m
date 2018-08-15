function [S, f, v, e] = m_music(signal, Fs, n_sins, varargin)
%This function is a wrapper of the pmusic algorithm of Matlab
%   signal      : the signal on which is computed pmusic
%   Fs          : the sampling frequency of the original signal
%   n_sins      : number of sinusoids that generates the signal
%---optional----
%   nfft        : the size of window fft
%   resolution  : resolution of pmusic in Hz
%   freq_min    : minimum frequency search
%   freq_max    : maximum frequency search

resolution = 1;
freq_min = 0;
freq_max = floor(Fs / 2);

if nargin >= 4
    resolution = varargin{1};
end
if nargin >= 5
    freq_min = varargin{2};
end
if nargin >= 6
    freq_max = varargin{3};
end

freq_range = [freq_min:resolution:freq_max];

[S, f, v, e] = pmusic(signal, 2*n_sins, freq_range, Fs);
end

