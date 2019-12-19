function dxdt = Derivs(t,xin,CD)

x = xin(1);
v = xin(2);


rho = 1.225;
S = 1;
g = 9.81;
m = 5;

xdot = v;
F = -m*g + (0.5)*rho*v^2*S*CD;
vdot = F/m;

dxdt = [xdot;vdot];