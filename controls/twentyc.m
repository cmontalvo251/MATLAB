function twentyc()

clc
close all

%%%%Numerical Solution
tspan = [0 10];
zinitial = [0;0];
[tout,zout] = ode45(@Derivs,tspan,zinitial);
figure()
plot(tout,zout(:,1))

%%%%Analytical Solution
%  A + 10/25 = 0
% -4*exp(-4*t)*(Acos + Bsin) + exp(-4t)*(3Asin + 3Bcos)
% -4A + 3B = 0
A = -10/25;
B = 4/3*A;

x_analytical = exp(-4*tout).*(A*cos(3*tout)+B*sin(3*tout))+10/25;

hold on
plot(tout,x_analytical,'r--')


function zdot = Derivs(t,z)
%%%% z = [x;xdot]
%%%% zdot = [xdot;xdbldot];
x = z(1);
xdot = z(2);
xdbldot = -8*xdot - 25*x + 10;

zdot = [xdot;xdbldot];