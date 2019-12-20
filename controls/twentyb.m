function twentyb()
clear
clc
close all

%%%%Numerical Solution
tspan = [0 6];
zinitial = [0;0];
[tout,zout] = ode45(@Derivs,tspan,zinitial);
fig=figure();
set(fig, 'color','white')
plot(tout,zout(:,1), 'black','Linewidth',2)
grid on
xlabel('Time (Sec)')
ylabel('Current')
title('Current vs Time')

%%%%Analytical Solution
s1 = -4;
s2 = -2;

matrixDE = [-1 18;-18 -1];
solDE = [0;5];

DE = inv(matrixDE)*solDE;
D = DE(1);
E = DE(2);

matrixAB = [1 1;-4 -2];
solAB = [-D;-3*E];

AB = inv(matrixAB)*solAB;
A = AB(1);
B = AB(2);

x_analytical = A*exp(s1*tout) + B*exp(s2*tout) + D*cos(3*tout) + E*sin(3*tout);


%set(fig, 'color','white')
hold on
plot(tout,x_analytical,'r--','Linewidth',4)
%xdot_analytical = s1*A*exp(s1*tout) + s2*B*exp(s2*tout) - 3*D*sin(3*tout) + 3*E*cos(3*tout);
%plot(tout,xdot_analytical,'b-','Linewidth',4)
grid on
xlabel('Time (Sec)')
ylabel('Current')
title('Current vs Time')


function zdot = Derivs(t,z)
x = z(1);
xdot = z(2);

xdbldot = 5*sin(3*t) - 6*xdot - 8*x;

zdot = [xdot;xdbldot];