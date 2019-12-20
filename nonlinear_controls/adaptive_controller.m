%%%%Let's estimate some quadcopter roll dynamics
function adaptive_controller()
global a ahat u phic phidbldottilde P 
close all
clc

%%%%Let's simulate the system
dt = 0.01;
tout = 0:dt:1000;
xinitial = [0;0;0];
a = 2;
ahat = 5;
xout = zeros(length(tout),3);
xout(1,:) = xinitial';
ahat_vec = 0*tout;
ahat_vec(1) = ahat;
u_vec = 0*tout;
phic_vec = 0*tout;
phidbldot_measured = 0*tout;
P = 0;
for idx = 1:length(tout)-1
    xout(idx+1,:) = xout(idx,:) + Derivs(tout(idx),xout(idx,:))*dt;
    ahat_vec(idx+1) = ahat;
    u_vec(idx+1) = u;
    phic_vec(idx+1) = phic;
    phidbldot_measured(idx+1) = phidbldottilde;
    integral = (phidbldot_measured(idx+1)^2)*dt;
    if integral ~= 0
        P = P + 1/integral;
    end
end
%%%%Plot stuffs
plot(tout,xout(:,1))
hold on
plot(tout,phic_vec,'r--')
xlabel('Time')
ylabel('Angle')
legend('State','Command')
figure()
plot(tout,ahat_vec)
hold on
plot(tout,xout(:,3),'r--')
legend('Ahat In-Situ','Ahat Dynamic')
figure()
plot(tout,u_vec)
ylabel('Control Input')

%%%Estimate mhat after the fact
%mhat = int ( xdbldot * u ) / int ( xdbldot ^2 )
N = (length(tout)-1);
top_int = sum(phidbldot_measured.*u_vec)/N;
bott_int = sum(phidbldot_measured.^2)/N;
ahat_e = top_int/bott_int

%%%%Derivatives function
function dxdt = Derivs(t,x)
global a ahat u phic phidbldottilde P
phi = x(1);
phidot = x(2);
ahat_state = x(3);

%%%Control input 
phic = 30*pi/180*sin(t);
kp = 16/ahat;
kd = 8/ahat;
u = kp*(phic-phi) + kd*(-phidot);

%%%Dynamics
phidbldot = u/a;

%%%In-situ online estimation but kind of a bad idea
err = (-10+2*randi(20));
%err = 0;
phidbldottilde = phidbldot*(1+err/100);
if phidbldottilde ~= 0
    ahat = u/phidbldottilde;
end

e = phidbldottilde*ahat_state-u;
ahatdot = -P*phidbldottilde*e;
if abs(ahatdot) > 0.01
    ahatdot = sign(ahatdot)*0.01;
end

dxdt = [phidot,phidbldot,ahatdot];


