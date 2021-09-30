clear
clc
close all

theta = linspace(0,2*pi,200);
r = 5;

x = r*cos(theta);
y = r*sin(theta);

plot(x,y)

axis equal


t = 0:0.1:3;
x0 = 0;
v = 15;
elev = 45*pi/180;
vx = v*cos(elev);
x = x0 + vx*t;
a = -9.81;
y0 = 0;
vy = v*sin(elev);
y = y0 + vy*t + (1/2)*a*t.^2;

plot(x,y)

ylim([0 6])
