function [x,y] = convertLATLON(lat,lon,origin)
%%%%Convert latitutde and longitude(deg) to x and y(m)
%%%Assuming origin = [lat0,lon0];

NM2FT=6076.115485560000;
FT2M=0.3048;

Ox = origin(1);
Oy = origin(2);


x = (lat - Ox).*60.*NM2FT*FT2M; %%//North direction - Xf , meters
y = (lon - Oy).*60.*NM2FT*FT2M.*cos(Ox*pi/180); %%//East direction - Yf, meters

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
