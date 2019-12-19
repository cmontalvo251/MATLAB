function twentyonea()
clear
clc
close all
%%%%Numerical Solution
tspan = [0 20];
zinitial = [0;0];
[tout,zout] = ode45(@Derivs,tspan,zinitial);
fig=figure();
set(fig, 'color','white')
plot(tout,zout,'b-','Linewidth',4)
grid on
xlabel('Time (Sec)')
ylabel('Current')
title('Current vs Time')
%%%%Analytical Solution
s1 = -1+1i;
s2 = -1-1i;
matrixDE = [-2 4;-4 -2];
solDE = [0;2];
DE = inv(matrixDE)*solDE;
D = DE(1);
E = DE(2);
matrixAB = [1 1;s1 s2];
solAB = [-.2*D;-.1*E];
AB = inv(matrixAB)*solAB;
A = AB(1);
B = AB(2);
x_analytical = exp(s1*tout)*[A*cos(tout)+B*sin(tout)]+ D*cos(2*tout) + E*sin(2*tout);
x_analytical(0) = 2;
x_limit = D*cos(2*tout) + E*sin(2*tout);
xdot_analytical = -exp(-tout)*[A*cos(2*tout)+B*sin(2*tout)]+(exp(-tout)*[-2*A*cos(2*tout)+2*B*sin(2*tout)])+2*D*sin(2*tout)+2*E*cos(2*tout);
xdot_analytical(0)=-3;  
fig=figure();
set(fig, 'color','white')
hold on
plot(tout,x_analytical,'r--','Linewidth',4)
plot(tout,x_limit,'g-','Linewidth',4)
plot(tout,xdot_analytical,'black-','Linewidth',4)
grid on
xlabel('Time (Sec)')
ylabel('Current')
title('Current vs Time')
function zdot = Derivs(t,z)
x = z(1);
xdot = z(2);
xdbldot = sin(2*t)-2*xdot-2*x;
zdot = [xdot;xdbldot];