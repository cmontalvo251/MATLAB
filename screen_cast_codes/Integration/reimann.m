clear
clc

N1 = 80;
x = linspace(0,pi,N1);
dx = x(2)-x(1);
fx = 5+3*cos(x);
fx2 = 5+3*cos(x+dx);
IT = sum(0.5*(fx+fx2))*dx