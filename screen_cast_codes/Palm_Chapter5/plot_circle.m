clear
clc
close all

theta = 0:0.001:2*pi;
r = 1;
x = r*cos(theta);
y = r*sin(theta);

plot(x,y)

close all

t = 0:0.1:3;
x0 = 0;
y0 = 0;
v0x = 10;
v0y = 5;
x = x0 + v0x*t;
y = y0 + v0y*t - ( 1/2)*9.81*t.^2;

plot(x,y)

ylim([0 2])