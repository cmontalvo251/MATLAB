clear
clc
close all

Y = 2009-2000;

%%%%number of days since 2000
N = Y*365 + round(Y/4);

days = N:1:(N+365);

%%%%Declination angle of the sun in the year 2010
dec = -asind(0.39779*cosd(0.98565*(days+10)+1.914*sind(0.98565*(days-2))));

plottool(1,'Sun Declination',18,'Days from 2000','Declination Angle(deg)');
plot(days,dec,'LineWidth',2)
xlim([min(days) max(days)])

%%%%Solar Elevation Angle
%%% Hour Angle
h = 12; %Noon
%%% Latitude
phi = 18.475833;
alpha_s = asind(cosd(h)*cosd(dec)*cosd(phi)+sind(dec)*sind(phi));

plottool(1,'Solar Elevation Angle',18,'Days from 2000','Solar Elevation Angle');
plot(days,alpha_s,'LineWidth',2)
xlim([min(days) max(days)])
