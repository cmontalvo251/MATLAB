function duffing_control()
global alfa bata c
clc
close all

bata = 1;
alfa = -2;
c = 2;

%%%%alfa > 0, 1 eq , 1 stable
%%%%alfa < 0, 3 eq , 2 stable 1 unstable

xinitial = [-10;-10];
[tout,xout] = ode45(@Nonlin,[0 20],xinitial);
plot(xout(:,1),xout(:,2),'b-')
hold on
plot(xout(1,1),xout(1,2),'g*')
plot(xout(end,1),xout(end,2),'rs')

%figure()
%plot(tout,xout)

function dxdt = Nonlin(t,xvec)
global alfa bata c

x = xvec(1);
xdot = xvec(2);
kp = -20;
kd = -1;
u = kp*(x) + kd*(xdot);

xdbldot = -c*xdot - alfa*x - bata*x^3;

dxdt = [xdot;xdbldot];