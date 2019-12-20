function van_der_pol_eqns()
close all

global u

%%%%Simulate Linear System
tspan = [0 100];
x0 = [45*pi/180;0];

[tout,xout] = ode45(@Derivs,tspan,x0);
uout = 0*tout;
for idx = 1:length(tout)
    dxdt = Derivs(tout(idx),xout(idx,:));
    uout(idx) = u;
end

figure()
plot(tout,xout)

figure()
plot(tout,uout)

function dxdt = Derivs(t,xvec)
global u

x = xvec(1);
xdot = xvec(2);

%%%Add control
kp = 0;
kd = 0;
u = -kp*(x) - kd*xdot;
if abs(u) > 400
    u = sign(u)*400;
end
m = 1;
c = 0.2;
k = 3;
xdbldot = (-k*x - 2*c*(x^2-1)*xdot)/m;

dxdt = [xdot;xdbldot];