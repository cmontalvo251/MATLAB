function runtaylor()

close all
clear
clc

x = -pi:0.1:pi;

x0 = 0;

y = sin(x);

yest = mytaylor(x,x0,5);

plot(x,y,'b--')
hold on
plot(x,yest,'r--')