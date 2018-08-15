function [Y_fft_index, pos] = back_search(Y_fft_index,pos, min_slope_value)
% This function will return the second peak of a FFT of a power spectrum.
% It is used to find the 'period' of the power spectrum.
%   Y_fft       : The spectrum of the power spectrum of the signal

% Used to keep track of the 'depth' for searching other peaks
max_value = Y_fft_index(pos,1);
half_diff = (max_value - min_slope_value) / 2;

Y_fft_index_split = Y_fft_index(1:pos,:);               % remove all index beyond maximum index
sorted_fft = sortrows(Y_fft_index_split, 'descend');    % sort in descend order

list_index = 2;                 % the index of Y_fft matrix
prev_index = pos;               % the index corresponding to the peak
prev_value = max_value;         % the value 

smaller_peak = false;
upper_half = true;

while(~smaller_peak && upper_half && list_index <= size(Y_fft_index_split, 1))
    % read row of sorted_fft
    curr_index = sorted_fft(list_index,2);
    curr_value = sorted_fft(list_index,1);
    
    % compute diff and step
    diff = (max_value - curr_value);
    step = (prev_index - curr_index);
    
    if diff > half_diff
        upper_half = false;
    end
    if step > 1
        smaller_peak = true;
    end
    prev_index = curr_index;
    prev_value = curr_value;
    list_index = list_index + 1;
end

% if it has found a smaller peak higher than the upper half, set pos to its
% index
if smaller_peak && upper_half
    pos = sorted_fft(list_index-1,2);
end
end

