function scatter_pmusic(S,f)
% plot a scatter graph of pmusic
scatter(f, S);
grid on;
grid minor;
hold on;
title('Spectrogram of signal');
xlabel('f (Hz)');
ylabel('Y (f)');
hold off;
end

