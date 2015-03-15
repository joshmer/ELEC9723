function x = plot_spectra(signal,fs)
% Plots the magnitude and phase spectra of the signal given the sampling frequency.
% Only plots the first half of the signal - [0,pi]

signal_fft = fft(signal,fs);
signal_mag = abs(signal_fft(1:fs/2));
signal_ph = atan2(imag(signal_fft(1:fs/2)),real(signal_fft(1:fs/2)));
%signal_ph = phase(signal_fft);

% Plot magnitude
figure('name','Magnitude and Phase');
subplot(2,1,1);
plot(signal_mag);
title('Magnitude');
axis tight;

% Plot phase
subplot(2,1,2);
plot(unwrap(signal_ph));
title('Phase');
%plot(signal_ph);
axis tight;

% dB magnitude, optional
% figure('name','dB Magnitude');
% plot(20*log10(signal_mag));
% title('dB magnitude');
