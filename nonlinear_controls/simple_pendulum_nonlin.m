function simple_pendulum_nonlin()
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

theta = xout(:,1);
figure()
plot(tout,theta)

figure()
plot(tout,uout)

function dxdt = Derivs(t,x)
global u

theta = x(1);
thetadot = x(2);

%%%Add control
kp = 1;
kd = 0.5;
u = -kp*(theta-pi) - kd*thetadot;
if abs(u) > 400
    u = sign(u)*400;
end

g = 3.1;
L = 20;

thetadbldot = -g/L*sin(theta) + u;

dxdt = [thetadot;thetadbldot];