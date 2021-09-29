clear
clc
close all

disp('GNC QUALIFICATION')

%%USer defined parameters
apogee = 1000; %%km above surface
perigee = 100000; %km above surface
N = 10000;

%%%Run the orbit model
[x,y,z,t,T_orbit] = orbit_model(apogee,perigee,N,0);
disp(['Orbit Time = ',num2str(T_orbit)])

%%%Plot the orbit
plot3(x,y,z)
%%%Plot Altitude
altitude = sqrt(x.^2 + y.^2 + z.^2);
figure()
plot(altitude)

%%%Call the magnetic field model
addpath('../igrf') %%%Hey you need to make sure you download igrf from mathworks
[BxI,ByI,BzI] = magnetic_field(x,y,z);

%%%Plot the magnetic field
figure()
plot(t,BxI,'b-')
hold on
plot(t,ByI,'r-')
plot(t,BzI,'g-')