function y = fft_out(x,n)
% This calculates the n-point FFT of a signal, x.
% n will always be corrected to the next highest power of two.
% x will also be corrected so the length is equal to n

%-------------------------------------------------------------------------
% Check if n is a power of 2
two_pow = 2.^[0:1:20];
if max(n == two_pow) == 0
    n = 2.^sum(n > two_pow);
end

% Make sure length(x) is equal to n
x_len = length(x);
if x_len ~= n
    zero_len = n - x_len;
    x = [x, zeros(1,zero_len)];
end

y = fft_actual(x);

%-------------------------------------------------------------------------
% Perform FFT
function y_out = fft_actual(x)

n = length(x);

if n > 1
    x_even = x(1:2:n);
    x_odd = x(2:2:n);
%     X_even = fft_out(x_even,n/2);
%     X_odd = fft_out(x_odd,n/2);
    X_even = fft_actual(x_even);
    X_odd = fft_actual(x_odd);
%    k = 0:n/2 - 1;
%    w = exp(-1i.*2.*pi.*[0:n/2-1]./n);
    temp = exp(-1i.*2.*pi.*[0:n/2-1]./n) .* X_odd;
    y_out = [(X_even + temp), (X_even - temp)];
else
    y_out = x;
end