function y = spect_out(varargin)
% spect_out(signal,fs,win_len,win_sep,win_shape)

% Assign variables
signal = varargin{1};   % Array
signal = signal';
fs = varargin{2};   % Value
win_len = varargin{3};  % Value
win_sep = varargin{4};  % Value

% Check if the window shape was also passed through
if length(varargin) == 5
    win_shape = varargin{5};    % Array
    win_len = length(win_shape);    % In case of Operator Error
else
    % Generate Hanning window by default
    % 0.5*(1-cos(2*pi*n/(N-1)))
    h_sample = [0:win_len-1];
    win_shape = 0.5*(1 - cos(2*pi*h_sample/(win_len-1)));
end

%y = zeros(signal_len + win_len-1,ceiling(signal_len/win_sep));

% Loop through the signal and calculate windowed FFTs
cnt = 1;
for i=1:win_sep:length(signal)-win_len
    % Must transpose win_shape for dot product
    x_temp = signal(i:i+win_len-1) .* win_shape;
    x_fft = fft(x_temp,fs);
    y(cnt,:) = x_fft(1:fs/2);
    cnt = cnt + 1;
end

% Calculate time and frequency vectors
f = [0:fs/2-1]; % FFT is performed based on fs
t = [0:win_sep:length(signal)-win_len]/fs;

% Plots
figure('name','Spectrogram of signal');
surf(f,t,20*log10(abs(y)),'EdgeColor','none');
xlabel('Frequency');
ylabel('Time');
axis xy;
axis tight;
colormap default;
view(0,90);

