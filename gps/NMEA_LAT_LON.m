function out = NMEA_LAT_LON(IN)

l = str2num(IN)/100;
l_deg = floor(l);
l_min = (l-l_deg)*100;
out = l_deg + l_min/60;

% Copyright - Carlos Montalvo 2016
% You may freely distribute this file but please keep my name in here
% as the original owner