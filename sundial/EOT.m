clear
clc
close all

W = 2*pi/365.24; 
D = linspace(0,365.24,100);
A = W*(D+10);
B = A + 2*0.0167*sin(W*(D-2));
earth_tilt = 23.44*pi/180;
C = (A-atan(tan(B)/cos(earth_tilt)))/pi;
EOTvec = -720*(C-round(C));
Lat = 18.475833
Long = -69.882778
GMT_offset = -4*15;
sundial_offset = Long - GMT_offset;
minute_offset = sundial_offset*4;
EOT_corrected = EOTvec - minute_offset;
plottool(1,'EOT',18);
plot(1+D/30,EOT_corrected,'b-','LineWidth',2)
xlabel('Month of The Year')
ylabel('Change in Minutes')
title('CASAS REALES')
ylim([20 55])
xlim([1 13])

