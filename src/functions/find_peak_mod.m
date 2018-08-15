function [index,other] = find_peak_mod(Y_fft)
% This function will return the second peak of a FFT of a power spectrum.
% It is used to setup the search without the first slope and then compute 
% the second peak index using another function called back_search().
% It is used to find the 'period' of the power spectrum.
% 
%   Y_fft       : The spectrum of the power spectrum of the signal

% create a matrix with 
positions = (1:size(Y_fft,1)).';
Y_fft_index = cat(2, Y_fft, positions);
other = 0;

% This while loop removes the first slope.
% Assuming that the function is monotonically decreasing,
% it will stop at the bottom of the slope.
prev_val = inf;         % value of the previous point. Initialize at infinity
curr_val = 0;           % curr value, set to zero
pos = 0;                % the position in the index (will be set to 1 at the beginning of the loop)
smaller = true;         % is the current value smaller than the previous ?
while(smaller && pos <= size(Y_fft_index, 1))
    pos = pos + 1;                      % go to the next position
    curr_val = Y_fft_index(pos,1);    
    if (curr_val <= prev_val)
        prev_val = curr_val;
    else
        smaller = false;
    end
end

index_end_slope = pos-1;                                % set the position to the bottom of the slope
Y_fft_index = Y_fft_index(index_end_slope:end, :);      % remove the first slope from Y_fft
min_slope_value = Y_fft_index(1,1);                     % the minimal slope value corresponds to the first index

% Select from 0 to max index
sorted_fft = sortrows(Y_fft_index, 'descend');  % sort the Y_fft values in descend order
prev_max_index = sorted_fft(1,2);               % select the index of the maximum value of Y_fft
Y_fft_index = Y_fft_index(1:prev_max_index,:);  % select from Y_fft_index [begin_Y_fft, index_max_value]


smaller_peak = false;   % if found a smaller peak left to the current one
while(~smaller_peak)
    [Y_fft_index, max_index] = back_search(Y_fft_index, prev_max_index, min_slope_value);
    % if found a new peak
    if max_index < prev_max_index
        smaller_peak = true;
        prev_max_index = max_index;
    elseif max_index == prev_max_index
        smaller_peak = false;
    end
end
index = prev_max_index;
end

