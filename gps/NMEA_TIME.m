function out = NMEA_TIME(TIME,units)

TIME(TIME == ':') = [];

hour = str2num(TIME(1:2));
min = str2num(TIME(3:4));
sec = str2num(TIME(5:6));

if strcmp(units,'sec')
    out = sec + min*60 + hour*3600;
elseif strcmp(units,'hrs')
    out = hour + min/60 + sec/3600;
end

% Copyright - Carlos Montalvo 2016
% You may freely distribute this file but please keep my name in here
% as the original owner