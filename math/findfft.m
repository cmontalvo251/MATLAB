close all
N = length(Umap)
x = linspace(-500,500,N);
time = x./20;
time = time - time(1);
data = Wmap;
%time = 0:0.001:5;
%data = 10*sin(2*pi*1*time) + 10;
%N = length(data);

% first, discretize data with even spacing
t  = linspace( time(1), time(end), N )';    % time vector
Fs = 1/(t(2) - t(1));                       % samping frequency
x  = interp1( time, data, t, 'spline' );    % data

%% Use FFT to find frequency
% Use next highest power of 2 greater than or equal to length(x) to calculate FFT.
nfft= 2^(nextpow2(length(x))); 

% Take fft, padding with zeros so that length(fftx) is equal to nfft 
fftx = fft(x,nfft); 

% Calculate the numberof unique points
NumUniquePts = ceil((nfft+1)/2); 

% FFT is symmetric, throw away second half 
fftx = fftx(1:NumUniquePts); 

% Take the magnitude of fft of x and scale the fft so that it is not a function of the length of x
mx = abs(fftx)/length(x);

% Take the square of the magnitude of fft of x. 
mx = mx.^2; 

% Since we dropped half the FFT, we multiply mx by 2 to keep the same energy.
% The DC component and Nyquist component, if it exists, are unique and should not be multiplied by 2.
if rem(nfft, 2) % odd nfft excludes Nyquist point
  mx(2:end) = mx(2:end)*2;
else
  mx(2:end -1) = mx(2:end -1)*2;
end

% This is an evenly spaced frequency vector with NumUniquePts points. 
f = (0:NumUniquePts-1)*Fs/nfft; 

% Generate the plot, title and labels. 
plot(f,mx); 
title('Power Spectrum'); 
xlabel('Frequency (Hz)'); 
ylabel('Power'); 

%%Test and see if this is true
figure()
part = zeros(1,N);
mxm = max(mx);
md = mean(data);
for ii = 1:length(mx)
  part = part + md*(mx(ii)/mxm)*cos(2*pi*f(ii)*time);
end
plot(time,part,'r-')
hold on
plot(time,data)

[maxpow, i] = max(mx(3:end));
freq = f(i+2);

%% Use frequency to find period, then find average
np = 10; % number of periods
T = 1/freq;
t1 = t(end) - np*T;
dt = 1/Fs;

[foo, it1] = min(abs(t - t1));

dx = zeros(size(x));
for i = it1:length(t)
    dx(i) = x(i)*dt;
end

average = sum(dx)/(np*T);

% figure;
% plot( time, data, 'k-', ...
%       t, x, 'k--', ...
%       time, average*ones(size(time)),'k-.', ...
%       'LineWidth', 2 )
% legend('data','fit','avg')
% xlabel( 't' )
% ylabel( 'x' )
% grid on
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
