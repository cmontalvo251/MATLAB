function first_order()

close all
clc

[tout,zout] = ode45(@Derivatives,[0 10],0);

xout = zout(:,1);

plot(tout,xout)



function zdot = Derivatives(t,z)

x = z(1);

xdot = 5*cos(2*t) - 7*x;

zdot = xdot;