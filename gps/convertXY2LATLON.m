function [lat,lon] = convertXY2LATLON(x,y,origin)

NM2FT=6076.115485560000;
FT2M=0.3048;

alf = 60*NM2FT*FT2M;

Ox = origin(1);
Oy = origin(2);

lat = x./alf + Ox;
lon = y./(alf*cos(Ox*pi/180)) + Oy;

% Copyright - Carlos Montalvo 2016
% You may freely distribute this file but please keep my name in here
% as the original owner