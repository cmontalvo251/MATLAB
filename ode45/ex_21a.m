function ex_21a()

clear
clc
close all
%%%Solving using ODE45
[tout,zout] = ode45(@Derivatives,[0 20],[2;-3]);
xout = zout(:,1);
%%%PLOT NUMERICAL SOLUTION
plot(tout,xout)
hold on
%%%%COMPUTE ROOTS
r1 = -1+i;
r2 = -1-i;
%%%SOLVE FOR A AND B
matAB = [-2 -4;4 -2];
ABans = [1;0];
%%%INVERT MATAB to get AB
AB = matAB\ABans;  %%%also possible to do inv(matAB)*ABans
A = AB(1);
B = AB(2);
%%%SOLVE FOR C1 and C2
matC1C2 = [1 1;r1 r2];
C1C2ans = [2-B;-3-2*A];
c1c2 = inv(matC1C2)*C1C2ans;
c1 = c1c2(1);
c2 = c1c2(2);
%%%%ANALYTICAL SOLUTION
xout_analytical = c1*exp(r1*tout) + c2*exp(r2*tout) + A*sin(2*tout) + B*cos(2*tout);

plot(tout,xout_analytical,'r--','LineWidth',8)

function dzdt = Derivatives(t,z)
x = z(1);
xdot = z(2);
xdbldot = sin(2*t) - 2*xdot - 2*x;
dzdt = [xdot;xdbldot];





