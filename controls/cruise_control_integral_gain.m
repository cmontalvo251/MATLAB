function cruise_control()
global ki kp vc

clc
close all

kp = 10;
ki = 10;
vc = 10;

[tout,zout] = ode45(@Derivatives,[0 10],[0;0;0]);

%size(zout)
v = zout(:,1);
vtilde = zout(:,2);
eint = zout(:,3);

e = vc - vtilde;
u = kp*e + ki*eint;
%u(u>100)=100;

figure()
plot(tout,v)
ylabel('v')

figure()
plot(tout,eint)
ylabel('eint')

figure()
plot(tout,u)
ylabel('u')

figure()
plot(tout,e)
ylabel('e')




function dzdt = Derivatives(t,z)
global kp ki vc
%%% z = [v,vtilde,eint]

v = z(1);
vtilde = z(2);
eint = z(3);

e = vc - vtilde;
u = kp*e + ki*eint;

%if u > 100
%    u = 100;
%end

vdot = -5*v + u;
vtildedot = -15*vtilde + 15*v;
eintdot = e;

dzdt = [vdot;vtildedot;eintdot];