function found_partials = search_partials_freq(v, Fs, period, partials, search_ratio, search_resolution)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
estimated_partials = ((1:n_partials) * period).';
ratio_diff = period * search_ratio/2;
resolution = 1 / ratio_diff;
max_search_range = cat(2, estimated_partials-ratio_diff, estimated_partials+ratio_diff);

frequencies = max_search_range(1,1):resolution:max_search_range(1,2);
for n = 2:n_partials
    frequencies = cat(1, frequencies,max_search_range(n,1):max_search_range(n,2));
end

%p = music_f(v, Fs, frequencies.');

%plot(frequencies.', 20*log10(p));


found_partials = frequencies;

end

