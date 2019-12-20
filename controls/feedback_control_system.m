%%%%%Open Loop System
function feedback_control_system()
clc
close all

global K1 K2 yc OL

%%%%Transfer Function
G_OL = tf([50],[1 1 0])
step(G_OL)

%%%Ode45
K1 = 0;
K2 = 0;
yc = 3;
OL = 1;
[tout,yout] = ode45(@Derivs,[0 100],[0;0]);

hold on
plot(tout,yout(:,1),'r-')

%%%Closed Loop

%%%Transfer Function 
K1 = 16/50;
K2 = 3/50;
denom = [1 (1+50*K2) 50*K1]
roots(denom)
G_CL = tf([50*K1],denom)
figure()
step(G_CL)

%%%Ode45
yc = 1;
OL = 0;
[tout,yout] = ode45(@Derivs,[0 3],[0;0]);
hold on
plot(tout,yout(:,1),'r-')

function dydt = Derivs(t,yvec)
global K1 K2 yc OL

y = yvec(1);
ydot = yvec(2);
u = K1*(yc-y) - K2*ydot + 1*OL;
ydbldot = 50*u - ydot;
dydt = [ydot;ydbldot];