function jan_26()
close all

[tout,zout] = ode45(@Derivatives,[0 10],[0;0]);

xout = zout(:,1);

plot(tout,xout)


%%%Analytic Solution
a = 5/2;
w = sqrt(15/4);
%%%Solve for A,B,C,D
mat = [1 0 1 0;5 1 0 1;10 5 1 0;0 10 0 1];
sol = [0;0;3;0];
ABCD = inv(mat)*sol;
A = ABCD(1);
B = ABCD(2);
C = ABCD(3);
D = ABCD(4);
x_analytic = A*cos(tout) + B*sin(tout) + D/w*exp(-a*tout).*sin(w*tout) + C*exp(-a*tout).*cos(w*tout) - C*a/w*exp(-a*tout).*sin(w*tout);

hold on
plot(tout,x_analytic,'r--')

xlabel('Time (sec)')
ylabel('Position (m)')
legend('Numerical ODE45','Analytic')

function dzdt = Derivatives(t,z)

x = z(1);
xdot = z(2);

xdbldot = 3*cos(t) - 5*xdot - 10*x;

dzdt = [xdot;xdbldot];