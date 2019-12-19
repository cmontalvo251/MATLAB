close all
clc
clear


V = 20;


azi = 45*pi/180;

elev = 45*pi/180;

vz = V*sin(elev);

v2D = V*cos(elev);

vx = v2D*sin(azi);
vy = v2D*cos(azi);

t = 0:0.1:2;

x0 = 0;y0 = 0;z0 =0;

az = -9.81;

x = x0 + vx*t;
y = y0 + vy*t;
z = z0 + vz*t + (1/2)*az*(t.^2);


plot3(x,y,z)

grid on

view([90 18])