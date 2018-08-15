function [B,f_1_0, partials, other] = inharmonicity(file)

% Read the file
[signal, Fs] = audioread(strcat(file.folder,'/',file.name));
signal_len = length(signal) / Fs; 

% Compute the Music spectrum and V and E
n_sins = 64;
S_resolution = 1;
[S,f,v,e] = m_music(signal(1:Fs), Fs, n_sins, S_resolution, 0, Fs/2);

% Compute the FFT of the Music spectrum
fft_fs = 1/((Fs/2)/length(S));
[Y_fft, Y_fft_indices] = param_FFT(S, fft_fs);

% Get the approximated frequency of the fundamental (f_1_0)
[index, other] = find_peak_mod(Y_fft);
period = 1 / Y_fft_indices(index);

% Search the partials
n_partials = 10;                % number of partials that we want to find
search_ratio = 8/9;             % the range of the search for each partials
search_resolution = 0.0001;     % the resolution we want to obtain
n_points =100;                  % the number of points per range on which MUSIC is computed

estimated_partials = ((1:n_partials) * period).';   % create a rough partials position estimation
found_partials = search_partials(v, Fs, period, estimated_partials, search_ratio, search_resolution, n_points);

% Compute the fundamental (f_1_0) and B
[f_1_0, B] = least_square_pond(found_partials);
partials = found_partials;
end
