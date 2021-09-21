clear
clc
close all

disp('GNC QUALIFICATION')

%%USer defined parameters
apogee = 1000; %%km above surface
perigee = 1000; %km above surface
N = 1000;

%%%Run the orbit model
[x,y,z,t,T_orbit] = orbit_model(apogee,perigee,N,1);
disp(['Orbit Time = ',num2str(T_orbit)])