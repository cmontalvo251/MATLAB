clear
clc
close all

%%%Transfer Function
Y = tf([32],[1 12 32 0])
%Y = zpk([],[0 -4 -8],[32])
impulse(Y)

t = linspace(0,2.5,100);
y_analytical = 1 - 2*exp(-4*t) + exp(-8*t);

hold on
plot(t,y_analytical,'r-')