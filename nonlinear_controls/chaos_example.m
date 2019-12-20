function chaos_example()
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

x = xout(:,1);
figure()
plot(tout,x)

%figure()
%plot(tout,uout)

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
xdbldot = -0.1*xdot - x^5 + 6*sin(t);

dxdt = [xdot;xdbldot];