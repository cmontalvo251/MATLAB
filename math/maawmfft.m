close all
clc
clear


x = -5:0.0001:5;
w = 5*pi/5;
A = 3;
f = A*sin(w*x);

plot(x,f,'b*')


mvec = 1:1:10;
bm = zeros(length(mvec));
am = zeros(length(mvec));
delx = 0.0001;
ctr = 1;
for m = mvec
    m
    bm(ctr) = 0;
    am(ctr) = 0;
    for xint = -pi:delx:pi
        integral_val = interp1(x,f,xint)*sin(m*xint)*delx;
        bm(ctr) = bm(ctr) + integral_val;
        integral_val = interp1(x,f,xint)*cos(m*xint)*delx;
        am(ctr) = am(ctr) + integral_val;
    end
    bm(ctr) = bm(ctr)/pi
    am(ctr) = am(ctr)/pi
    ctr = ctr + 1;
end

figure()
plot(mvec,bm)

figure()
plot(mvec,am)

% fc = 85/5;
% yc = 75/3;
% N = length(x);
% x_fft = ((1:N)-N/2)/fc;
% omega_fft = real(fft(f))/yc;
% 
% figure()
% plot(x_fft,omega_fft)

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
