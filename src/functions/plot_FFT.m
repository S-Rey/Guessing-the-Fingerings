function plot_FFT(Y, indices, Fs, varargin)
%Plot the FFT form freq_min to freq_max
%   Y           : the FFT that will be plot
%   indices     : its indices in Hz
%   Fs          : the sampling frequency of the original signal
%---optional----
%   freq_min    : the minimum frequency that will be present on the plot
%   freq_max    : the maximum frequency that will be present on the plot

min_freq = 0;
max_freq = floor(Fs / 2);

if nargin >= 4
    min_freq = varargin{1};
end
if nargin >= 5
    max_freq = varargin{2};
end
    
resolution = Fs / 2 / length(Y);
min_indice = floor(min_freq / resolution) + 1;
if max_freq == floor(Fs/2)
    max_indice = floor(max_freq / resolution);
else
    max_indice = floor(max_freq / resolution) + 1;
end


%disp(min_indice);
%disp(max_indice);


plot(indices(min_indice:max_indice),Y(min_indice:max_indice));
grid on;
grid minor;
hold on;
title('Spectrogram of signal');
xlabel('f (Hz)');
ylabel('Y (f)');
hold off;
end

