
function signal = create_signal(sinusoids,noise_amp, len_sign, Fs)
% Takes the sinusoids and noise_amp variable and turn them into a signal
% which lenght correspond to signal length.
%   sinusoids : [freq, phase, amp]
%   noise_amp : noise amplitude
%   len_sign: signal's lenght in second
%   Fs : sample frequency
    base = 1:1:len_sign*Fs;
    signal = zeros(size(base));
    for param=sinusoids.'
        signal  = signal + param(3) * sin(base * param(1)/Fs*2*pi + param(2));
    end
    if noise_amp ~= 0
        signal = signal + noise_amp * randn(size(signal));
    end
end



