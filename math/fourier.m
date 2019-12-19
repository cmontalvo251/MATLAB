function [a0,an,bn,xfit,ffit] = fourier(x,f,N,tau,Nf)
%function [a0,an,bn,ffit] = fourier(x,f,N,tau,Nf)
%%%n*w0 = w rad/m or angular frequency
%%%w = 2*pi*f thus f = w/(2*pi) which is frequency in 1/m
%%%lambda = 1/f which is period or in this case wavelength or meter
%%%lambda = 2*pi/(n*w0)
%%%Nf is the number of points you want for the fourier
%%%series. 

%%%%Zeroth Angular Frequency
w0 = pi/tau;

%%%Create x-vector for fit
xfit = linspace(-tau,tau,Nf);                      % Vector, and sample rate

%%%dx is used to integrate f. 
dx = x(2)-x(1);                                   

%%%Grab a0 
a0 = mean(f);

%%%Shift f by a0 for ease of fit
fs = f - a0;

nvec = 1:N;

%%%Remember that an and bn will be vectors
an = 0*nvec;
bn = 0*nvec;

%%%Pre-allocate
ffit = 0*xfit;

for n = nvec
    %%%Trapezoidal rule
    for idx = 1:length(fs)-1
        a1 = fs(idx)*cos(n*w0*x(idx));
        a2 = fs(idx+1)*cos(n*w0*x(idx+1));
        an(n) = an(n) + (1/tau)*(0.5*(a1+a2)*dx);
        
        b1 = fs(idx)*sin(n*w0*x(idx));
        b2 = fs(idx+1)*sin(n*w0*x(idx+1));
        bn(n) = bn(n) + (1/tau)*(0.5*(b1+b2)*dx);
    end
    %%%Recreate the waveform
    ffit = ffit + an(n)*cos(n*w0*xfit)+bn(n)*sin(n*w0*xfit);
end
ffit = ffit + a0;

