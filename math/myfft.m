function [d,an,bn,iters,frequencies,ffft] = myfft(f,t,nmax,iplot,ivideo)
%%%my fft function to create plots of an and bn
%%%myfft(f,t,ivideo,niters)
%%%w = fundamental freq - optional 

%close all
%clc

%%%Check for row vec
[r,c] = size(f);
if r > c
    f = f';
end
[r,c] = size(t);
if r > c
    t = t';
end

N = length(t);
tfft = linspace(t(1),t(end),N);
ffft = 0*tfft;

if iplot
  fig1 = figure('Name','Waveform');
  plot(t,f,'b-')
end

if nmax < 1
  nmax = 2;
end

iters = 1:nmax;
an = 0*iters;
bn = an;

L = t(end)-t(1); %%%

d = (1/L)*Reimmann(f,t);

%%%%Compute an and bn
for idx = 1:length(iters)
    n = iters(idx);
    w = 2*n*pi/L;
    data_a = cos(w*tfft);
    data_b = sin(w*tfft);
    %%%Reimann Sum
    ani = (2/L)*Reimmann(data_a.*f,t);
    bni = (2/L)*Reimmann(data_b.*f,t);
    an(idx) = ani;
    bn(idx) = bni;
    %%%Recreate the waveform
    ffft = ffft + an(idx)*data_a + bn(idx)*data_b;
    if ivideo
        cla;
        disp(['an = ',num2str(ani),' bni = ',num2str(bni)])
        plot(t,f,'b-')
        hold on
        plot(tfft,ffft,'r--')
        pause(0.01)
    end
    
end
ffft = d + ffft;
frequencies = iters/L;
if iplot
    hold on
    plot(tfft,ffft,'r--')
    legend('Original Waveform','Recreated Waveform')
    ax1 = gca;

    fig2 = figure('Name','Frequency Magnitudes');
    plot(frequencies,an,'b*')
    hold on
    plot(frequencies,bn,'r*')
    legend('a_n','b_n')
    xlabel('Frequencies(Hz)')
    ylabel('Magnitude')
    ax2 = gca;
end

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
