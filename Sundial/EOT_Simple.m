D = linspace(0,365.24,100);
B = 2*pi/365.24*(D+10) + 2*0.0167*sin(W*(D-2));
C = (2*pi/365.24*(D+10)-atan(tan(B)/cos(23.44*pi/180)))/pi;
EOTvec = -720*(C-round(C));
plot(D,EOTvec)
