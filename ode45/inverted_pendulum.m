function inverted_pendulum()

clc
close all

global B B2 A L m K alfa beta theta0 thetac g

g = 9.81;
L = 1.0;
m = 5.0;
K = 30.0;
alfa = 14.0;
beta = 40.0;
theta0 = 0*pi/180.;
thetac = 30*pi/180.;

A = [0,1,0;g/L,0,0;0,0,0];
B = [0;1/(m*L^2);0];
B2 = [0;0;1];

xinitial = [theta0;0;0];
tout = linspace(0,20,1000);

[tout,xout] = ode45(@Derivatives,tout,xinitial);
size(tout)
size(xout)
[tout,xoutNL] = ode45(@DerivativesNL,tout,xinitial);

plot(tout,xout(:,1)*180/pi,'b-')
hold on
plot(tout,xoutNL(:,1)*180./pi,'r-')
xlabel('Time (sec)')
ylabel('Angle (deg)')
legend('Linear','Nonlinear')
grid on

function [T,e] = controller(x)
global thetac beta alfa K
thetacdot = 0.0;
theta = x(1);
thetadot = x(2);
eint = x(3);
e = thetac - theta;
edot = thetacdot - thetadot;
W = 0;
T = K*alfa*e + K*edot + K*beta*eint + W;

function xdot = DerivativesNL(t,x)
global m L g
theta = x(1);
thetadot = x(2);
eint = x(3);
[T,e] = controller(x);
thetaddot = g/L*sin(theta) + T/(m*L^2);
eintdot = e;
xdot = [thetadot;thetaddot;eintdot];

function xdot = Derivatives(t,x)
global A B B2
theta = x(1);
thetadot = x(2);
eint = x(3);
[T,e] = controller(x);
xdot = A*x + B*T  + B2*e;
    
