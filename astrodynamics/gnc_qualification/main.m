clear
clc
close all

disp('GNC QUALIFICATION')

%%USer defined parameters
apogee = 1000; %%km above surface
perigee = 100000; %km above surface
N = 100000;

%%%Run the orbit model
[x,y,z,t,T_orbit] = orbit_model(apogee,perigee,N,0);
disp(['Orbit Time = ',num2str(T_orbit)])

plot3(x,y,z)

altitude = sqrt(x.^2 + y.^2 + z.^2);

figure()
plot(altitude)