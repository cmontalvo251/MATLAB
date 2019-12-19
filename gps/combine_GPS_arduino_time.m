function [total_time_arduino_and_GPS_min] = combine_GPS_arduino_time(data,GPS_start_col,iflag)
%%%%GPS only updates at 1Hz or 10Hz but the 9DOF sensor and even receiver
%%%%signals or SD card write typically will be on the order of every 100 ms
%%%%which is 10Hz but if it runs ever Arduino loop cycle it could be ever
%%%%10ms which would be 100 Hz. Anyway basically it means that each "line"
%%%%in the data file will have the exact same GPS time stamp but since
%%%%millis() is called every time the arduino prints to the SD card the
%%%%millis() timer will be different while the GPS time stamp might be the
%%%%same. In order to get a timer that is smooth we need to combine the
%%%%arduino timer and the GPS time stamp in an intelligent way 
%%%The function below assumes that GPS.hour,min,second and arduino timer
%%%are columns 1-4


%%%%%%%%%%%%%Now grab GPS time%%%%%%%%%%%%%
GPS_hour = data(:,GPS_start_col);
GPS_minute = data(:,GPS_start_col+1);
GPS_second = data(:,GPS_start_col+2);
arduino_Time_sec = data(:,GPS_start_col+3);

GPS_absolute_hrs = GPS_hour + GPS_minute/60 + GPS_second/3600;
GPS_absolute_minutes = GPS_hour*60 + GPS_minute + GPS_second/60;
GPS_absolute_seconds = GPS_hour*3600 + GPS_minute*60 + GPS_second;

%%%Arduino Time and GPS offset check. Just in case. Right now it's
%%%commented out
dt_gps = (GPS_absolute_seconds(end)-GPS_absolute_seconds(1));
dt_arduino = (arduino_Time_sec(end)-arduino_Time_sec(1));
%time_arduino_hr = (arduino_Time_sec-arduino_Time_sec(1))*dt_gps/(dt_arduino*3600);
time_arduino_hr = (arduino_Time_sec-arduino_Time_sec(1))/(3600);
time_arduino_min = time_arduino_hr*60;

%%%Offset arduino time by GPS_time
time_arduino_hr_offset_gps = time_arduino_hr + GPS_absolute_hrs(1);
%%%Loop through arduino time to stitch arduinoTime and GPS time together
gps_old = GPS_absolute_hrs(1);
lastGPStime = 0;
total_time_arduino_and_GPS = [];
for idx = 1:length(GPS_absolute_hrs)
  if GPS_absolute_hrs(idx) ~= gps_old
    lastGPStime = time_arduino_hr(idx);
    gps_old = GPS_absolute_hrs(idx);
  end
  new_time = GPS_absolute_hrs(idx) + time_arduino_hr(idx) - lastGPStime;
  if length(total_time_arduino_and_GPS)
    if new_time < total_time_arduino_and_GPS(end)
      lastGPStime = lastGPStime - total_time_arduino_and_GPS(end) + new_time(end);
      new_tme = GPS_absolute_hrs(idx) + time_arduino_hr(idx) - lastGPStime;
      if new_time < total_time_arduino_and_GPS(end)
          new_time = total_time_arduino_and_GPS(end);
      end
    end
  end
  total_time_arduino_and_GPS = [total_time_arduino_and_GPS;new_time];
end
total_time_arduino_and_GPS_min = (total_time_arduino_and_GPS-total_time_arduino_and_GPS(1))*60;

%%%%Plot all our different times to make sure we correctly measured time
%%%%here. Again we're stitching ArduinoTime and GPS time so things might
%%%%mess up
if iflag
    plottool(1,'Times',12,'Row Number','Time (hrs)');
    plot(GPS_absolute_hrs,'LineWidth',2)
    plot(time_arduino_hr_offset_gps,'r-','LineWidth',2)
    plot(total_time_arduino_and_GPS,'g-','LineWidth',2)
    legend('GPS Time','Scaled Arduino + GPS Offset Time','GPS+Arduino Time')
    ylim([total_time_arduino_and_GPS(1) total_time_arduino_and_GPS(end)])
end
