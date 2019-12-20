%%%%Let's estimate some quadcopter roll dynamics
function OEM()
global ahat a
close all
clc

%%%%Let's simulate the system
dt = 0.01;
tout = 0:dt:10;
xinitial = [0;0];
a = 20;




















ahat = 20.0;
xout = zeros(length(tout),2);
xout_est = zeros(length(tout),2);
xout(1,:) = xinitial';
xout_est(1,:) = xinitial';
for idx = 1:length(tout)-1
    xout(idx+1,:) = xout(idx,:) + Derivs(tout(idx),xout(idx,:))*dt;
    xout_est(idx+1,:) = xout_est(idx,:) + Derivs_est(tout(idx),xout_est(idx,:))*dt;
end
%%%%Plot stuffs
plot(tout,xout(:,1))
hold on
plot(tout,xout_est(:,1),'r--')
xlabel('Time')
ylabel('Angle')
legend('State','Estimate')

J = sum((xout(:,1)-xout_est(:,1)).^2)

%%%%Derivatives function
function dxdt = Derivs(t,x)
global a
phi = x(1);
phidot = x(2);

%%%Control input 
phic = 30*pi/180*sin(t);
kp = 16/a;
kd = 8/a;
u = kp*(phic-phi) + kd*(-phidot);

%%%Dynamics
phidbldot = u/a;

dxdt = [phidot,phidbldot];

%%%%Derivatives function
function dxdt = Derivs_est(t,x)
global ahat
phi = x(1);
phidot = x(2);

%%%Control input 
phic = 30*pi/180*sin(t);
kp = 16/ahat;
kd = 8/ahat;
u = kp*(phic-phi) + kd*(-phidot);

%%%Dynamics
phidbldot = u/ahat;

dxdt = [phidot,phidbldot];



