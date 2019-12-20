%%%Plot Lyapunov Function
clear
clc
close all

x1 = linspace(-5,5,100);
x2 = linspace(-5,5,100);

[xx1,xx2] = meshgrid(x1,x2);

V = 0.5*(xx1-1).^2 + 0.5*xx2.^2;

mesh(xx1,xx2,V)

kp = 300;
g = -xx1.*xx2 + xx2 - kp;
u = g./(xx1-xx2-1);
s = 1000;
u(u>s) = s;
u(u<-s) = -s;
Vdot = (xx1-1).*(xx2+u) + xx2.*(-u);

figure()
mesh(xx1,xx2,Vdot)