function plot_pmusic(S,f)
% plot a pmusic graph
plot(f, S);
grid on;
grid minor;
hold on;
title('Spectrogram of signal');
xlabel('f (Hz)');
ylabel('Y (f)');
hold off;
end

