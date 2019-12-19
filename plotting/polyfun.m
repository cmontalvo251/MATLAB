function polyfun()
close all

N = 0:3;

interior_angle = (N-2)*180./N;
%total_angle = (N-2)*180;

plottool(1,'Polyfun',18,'Number of Sides','Interior Angle (deg)')
plot(N,interior_angle,'b-')
%plot(N,total_angle,'r-')
%legend('Interior Angle','Total Angle')
