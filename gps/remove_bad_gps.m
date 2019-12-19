function data = remove_bad_gps(data,fix_col,iflag,nflag)
%%%This will remove all bad GPS data assuming that GPS.fix is in column
%%%fix_col

%%%First we need to find when we get a GPS lock
%%%Grab Fix Quality
GPS_fix = data(:,fix_col);
if iflag
    figure()
    plot(GPS_fix)
    ylabel('GPS Fix')
end

%%%%Need to search through file and remove data without a GPS loc
%loc = find(GPS_fix == 1); %%%Use this to remove ALL data without a GPS loc
%data = data(loc,:);

%%%%This will just remove the beginning fluff
%%%%CREATE A BETTER LOGIC ALGORITHM FOR THIS BECAUSE GPS_FIX IS ONLY SO GOOD
loc = find(GPS_fix == 1,1); %%Use this to remove just the data in the beginning when we were acquiring GPS signal. 
data = data(loc:end,:); %If the sensor loses signal we will still plot it. 

GPS_fix = data(:,fix_col);

if strcmp(nflag,'NALU') || strcmp(nflag,'META')
    %%%%Uncomment these lines of code if you are having issues with GPS getting
    %%%%a really bad lat and lon fix
    latitude = data(:,fix_col+1);
    longitude = data(:,fix_col+2);
    gps_speed = data(:,fix_col+3);
    gps_compass = data(:,fix_col+4);
    altitude = data(:,fix_col+5);

    loc = find(altitude ~= 0,1);
    last_alt = altitude(loc);
    loc = find(latitude > 28 & latitude < 32);
    last_gps_lat = latitude(loc(1));

    for idx = 1:length(GPS_fix)
        if (latitude(idx) < 28 || latitude(idx) >= 32)
            latitude(idx) = last_gps_lat;
        else
            last_gps_lat = latitude(idx);
        end
        if (longitude(idx) < -90 || longitude(idx) > -80)
            longitude(idx) =  last_gps_lon;
        else
            last_gps_lon = longitude(idx);
        end
        if (altitude(idx) > 1000 || altitude(idx) == 0)
            if last_alt ~= 0
                altitude(idx) = last_alt;
            end
        else
            last_alt = altitude(idx);
        end
        if (gps_speed(idx) > 50)
            gps_speed(idx) = last_speed;
        else
            last_speed = gps_speed(idx);
        end
        if (gps_compass(idx) > 360)
            gps_compass(idx) = last_compass;
        else
            last_compass = gps_compass(idx);
        end
    end

    data(:,fix_col+1) = latitude;
    data(:,fix_col+2) = longitude;
    data(:,fix_col+3) = gps_speed;
    data(:,fix_col+4) = gps_compass;
    data(:,fix_col+5) = altitude;
end

if iflag
    time_GPS = data(:,7);
    lat = data(:,9);
    lon = data(:,10);
    speed = data(:,11);
    GPS_heading = data(:,12);
    altitude = data(:,13);

    figure()
    plot(time_GPS,lat)
    xlabel('Time (sec)')
    ylabel('Latitude (Deg)')

    figure()
    plot(time_GPS,lon)
    xlabel('Time (sec)')
    ylabel('Longitude (Deg)')

    figure()
    plot(time_GPS,altitude)
    xlabel('Time (sec)')
    ylabel('Altitude (m)')

    figure()
    plot(lat,lon)
    xlabel('Latitude (Deg)')
    ylabel('Longitude (Deg)')

    figure()
    plot3(lat,lon,altitude)
    xlabel('Latitude (Deg)')
    ylabel('Longitude (Deg)')
    zlabel('Altitude (m)')
end