function nonlinear_msd()
global m b k0 k1

close all
clc

m = 1;
b = 2;
k0 = 3;
k1 = 4;

[tout,zout] = ode45(@Derivs,[0 20],[1.5;0]);

plot(tout,zout(:,1))
xlabel('Time (sec)')
ylabel('X')

figure()
plot(tout,zout(:,2))
xlabel('Time (sec)')
ylabel('xdot')

%%%Generate our Lyapunov function
figure()
x = -2:0.1:2;
xdot = -1:0.1:1;
[xx,xxdot] = meshgrid(xdot,x);
V = Lyapunov(xx,xxdot);
mesh(xx,xxdot,V)
hold on
plot3(zout(:,1),zout(:,2),Lyapunov(zout(:,1),zout(:,2)),'r--')

figure()
Vdot = LyapunovDot(xx,xxdot);
mesh(xx,xxdot,Vdot)
hold on
plot3(zout(:,1),zout(:,2),LyapunovDot(zout(:,1),zout(:,2)),'r--')

function Vout = Lyapunov(x,xdot)
global m k1 k0 b

Vout = 0.5*xdot.^2*m + 0.5*k0*x.^2 + 0.25*k1*x.^4;

function Vdot = LyapunovDot(x,xdot)
global m k0 k1 b

Vdot = -b*xdot.^2.*abs(xdot);

function dxdt = Derivs(t,xvec)
global m k0 k1 b 

x = xvec(1);
xdot = xvec(2);

xdbldot = (1/m)*(-b*xdot*abs(xdot) - k0*x - k1*x^3);

dxdt = [xdot;xdbldot];