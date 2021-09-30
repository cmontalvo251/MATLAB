close all

delx = 0.1;

L = 1000;
xmountain = 0:delx:L;
amp = [20 0 0.0 0.00];
freq = [1 2 10 100];
zmountain = 0*xmountain;
NWAVES = length(amp);
for idx = 1:NWAVES
    zmountain = zmountain + amp(idx)*sin(freq(idx)*pi*xmountain/100);
end    
