function data_ball = process_GPS_file(filename)
%%The parser in this file is based on the GPGGA protocol which 
%can be found at this website. http://aprs.gids.nl/nmea/


disp('Processing GPS')

fid = fopen(filename);

time_vec = [];
lon_vec = [];
lat_vec = [];
speed_kts_vec = [];
psi_vec = [];

if ~fid
  disp('File not found')
else
    EOF = 1;
    while EOF
        this_line = fgetl(fid);
        if length(this_line) > 0
            if this_line == -1
                EOF = 0;
            else
                %%%I need to parse each line by commas
                data_row = linesplit(this_line);
                if length(data_row) > 0
                    GPSFLAG = data_row{1};
                else
                    GPSFLAG = 'XXXXXXXXXXX';
                end
                if GPSFLAG(6) == 'C' && length(data_row) > 6
                    if data_row{3} == 'A'
                        LAT = data_row{4};
                        LON = data_row{6};
                    else
                        LAT = data_row{3};
                        LON = data_row{5};
                    end
                    TIME = data_row{2};
		  
                    lat_dec = NMEA_LAT_LON(LAT);
                    lat_vec = [lat_vec;lat_dec];
                    
                    lon_dec = NMEA_LAT_LON(LON);
                    lon_vec = [lon_vec;-lon_dec];
                              
                    time_dec = NMEA_TIME(TIME,'sec');
                    time_vec = [time_vec;time_dec];
      
                    speed_kts = str2num(data_row{8});
                    speed_kts_vec = [speed_kts_vec;speed_kts];
                    
                    psi_GPS = str2num(data_row{9});
                    psi_vec = [psi_vec;psi_GPS];
                end
            end
        end
    end
end

data_ball = {time_vec,lat_vec,lon_vec,speed_kts_vec,psi_vec};

return

length(time_vec)
length(lon_vec)

plot(time_vec)
figure()
plot(lon_vec)

%%%Offet Time
time_vec = time_vec - time_vec(1);

figure()
plot(time_vec,lon_vec)
xlabel('Time (sec)')
ylabel('Longitude (W)')

figure()
plot(lat_vec,lon_vec)
xlabel('Latitude (N)')
ylabel('Longitude (W)')

%%Convert to Cartesion Coordinates
NM2FT=6076.115485560000;
FT2M=0.3048;
x_vec = (lat_vec - lat_vec(1))*60*NM2FT*FT2M; %%//North direction - Xf , meters
y_vec = (lon_vec - lon_vec(1))*60*NM2FT*FT2M*cos(lat_vec(1)*180/pi); %%//East direction - Yf, meters

figure()
plot(x_vec,y_vec,'b-s')
hold on
plot(x_vec(1),y_vec(1),'^')
plot(x_vec(end),y_vec(end),'v')
xlabel('X (m)')
ylabel('Y (m)')

%%%%Compute Distance
%Compute heading as well
dist_vec = 0*time_vec;
heading_vec = 0*time_vec;
for idx = 2:length(time_vec)
    dx = x_vec(idx)-x_vec(idx-1);
    dy = y_vec(idx)-y_vec(idx-1);
    dist_vec(idx) = dist_vec(idx-1) + sqrt(dx^2+dy^2);
    heading_vec(idx) = atan2(dy,dx);
end

figure()
plot(time_vec,heading_vec*180/pi)
xlabel('Time (sec)')
ylabel('Heading (deg')

figure()
plot(time_vec,dist_vec)
xlabel('Time (sec)')
ylabel('Distance (m)')

%Run Distance Through a Derivative Filter to compute Speed
speed_vec = 0*time_vec;
raw_speed_vec = 0*time_vec;
s = 0.0;
for idx = 2:length(time_vec)
   raw_speed = (dist_vec(idx)-dist_vec(idx-1))/(time_vec(idx)-time_vec(idx-1));
   raw_speed_vec(idx) = raw_speed;
   if raw_speed == Inf
       raw_speed = speed_vec(idx-1);
   end
   speed_vec(idx) = s*speed_vec(idx-1) + (1-s)*raw_speed;
end

figure()
%plot(time_vec,speed_vec,'r-')
hold on
%speed_ms_vec = speed_kts_vec*0.51444;
plot(time_vec,speed_kts_vec,'b-')
%plot(time_vec,raw_speed_vec,'g-')
xlabel('Time (sec)')
ylabel('Speed (m/s)')

%%%Make cool 3D plots
figure()
plot3color(x_vec,y_vec,speed_kts_vec);
xlabel('X (m)')
ylabel('Y (m)')
zlabel('Speed (m/s)')
title('Speed (m/s)')

% Copyright - Carlos Montalvo 2016
% You may freely distribute this file but please keep my name in here
% as the original owner