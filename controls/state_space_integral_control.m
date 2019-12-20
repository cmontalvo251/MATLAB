function state_space_integral_control()
close all
clc

tspan = [0 40];

[tout,xout] = ode45(@Derivs,tspan,[0;0]);

%%%Velocity
plot(tout,xout(:,1))
%%%Integral of error
figure()
plot(tout,xout(:,2))
%%%Error itself
figure()
plot(tout,1-xout(:,1))


function dzdt = Derivs(t,z)
%%% z = [velocity,ei]

v = z(1);
ei = z(2);

%%%Control Input
vc = 1;
kp = 100;
ki = 1200;
T = kp*(vc-v) + ki*ei;

%%%EOMS 
m = (3000/2.2);
c = 500;
vdot = (T - c*v)/m;
eidot = vc-v;

dzdt = [vdot;eidot];

