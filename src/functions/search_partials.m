function found_partials = search_partials(v, Fs, period, estimated_partials, search_ratio, search_resolution, n_points)
% search the best approximation of partials by recursion
%   v                   :   eigenvectors of the noise subspace
%   Fs                  :   sampling frequency
%   estimated_partials  :   the previously estimated partials locations
%   search_ratio        :   the ratio which will set the range of search
%   search_resolution   :   the desired final resolution
%   n_points            :   number of points used for each range

n_partials = size(estimated_partials,1);
ratio_diff = period * search_ratio / 2;
resolution = period * search_ratio / n_points;

% generate the range of search
max_search_range = cat(2, estimated_partials-ratio_diff, estimated_partials+ratio_diff);

% generate the frequencies to which applied MUSIC
frequencies = max_search_range(1,1):resolution:max_search_range(1,2);
n_f_partials = size(frequencies,2);
indices_freq = [1 n_f_partials];
for n = 2:n_partials
    frequencies = cat(2, frequencies,max_search_range(n,1):resolution:max_search_range(n,2));
    indices_freq = cat(1, indices_freq, [(((n-1)*n_f_partials)+1) (n*n_f_partials)]);
end

p = music_f(v, Fs, frequencies.').';

% select new partials as max value of each range
new_partials = [];
for indices=indices_freq.'
    [value, max_indice] = max(p(indices(1):indices(2)));
    new_partials = cat(2,new_partials, frequencies(max_indice+indices(1)-1));
end

% if the desired resolution is reached
if resolution < search_resolution
   found_partials = new_partials; 
else
    found_partials = search_partials(v, Fs, period, new_partials.', search_ratio - (1/2*search_ratio), search_resolution, n_points);
end

end