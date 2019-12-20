%%%%% xdbldot + 2*xdot + 2*x = sin(2*t)
%%%%% x(0) = 2 and xdot(0) = -3
function problem21a()
close all
[tout,zout] = ode45(@Derivatives,[0 10],[2;-3]);
xout = zout(:,1);
xdotout = zout(:,2);

%%%This plots it
plot(tout,xout,'b-','LineWidth',2)
grid on
xlabel('Time (sec)')
ylabel(' X(t) ')
title(' Problem 21a ')

%%%Plot the solution obtained by hand
hold on
x_hand = exp(-tout).*(11/5*cos(tout)-3/5*sin(tout)) - 1/5*cos(2*tout) - 1/10*sin(2*tout);
plot(tout,x_hand,'r--','LineWidth',2)
legend('Numerical','Hand Calculation')


function  zdot = Derivatives(t,z)
x = z(1);
xdot = z(2);
xdbldot = -2*xdot - 2*x + sin(2*t);
zdot = [xdot;xdbldot];