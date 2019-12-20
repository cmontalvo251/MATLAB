function quad_hover()
close all

global u

%%%%Simulate Linear System
tspan = [0 100];
x0 = [-2;0;0];

[tout,xout] = ode45(@Derivs,tspan,x0);
uout = 0*tout;
for idx = 1:length(tout)
    dxdt = Derivs(tout(idx),xout(idx,:));
    uout(idx) = u;
end

x = xout(:,1);
figure()
plot(tout,x)

%figure()
%plot(tout,uout)

function dxdt = Derivs(t,xvec)
global u

x = xvec(1);
xdot = xvec(2);
eint = xvec(3);

%%%Add control
kp = 20;
kd = 10;
ki = 5;
xhover = -10;
Thrust = kp*(x-xhover) + kd*xdot + ki*eint;

g = 9.81;
m = 1.3;
xdbldot = -Thrust/m + g;

%%Ground Check
if x > 0
    xdbldot = 0;
    xdot = 0;
end

eintdot = x-xhover;

dxdt = [xdot;xdbldot;eintdot];