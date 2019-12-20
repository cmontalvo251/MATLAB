function PD_tune()
clc
close all

global CONTROL kp kd

%%%Simulate open loop system
CONTROL = 0;
[tout,xout] = ode45(@Derivs,[0 20],[0;0]);
plot(tout,xout)
m = 5;
c = 8;
k = 3;
A = [0 1;-k/m -c/m];
B = [0;1/m];
eig(A)
%% s = -0.6 and -1.0 - stable, overdamped
wn = sqrt(k/m) %% 0.7746
zed = c/(2*wn*m) %% 1.0328 > 1 so overdamped

%%%TUNE THE PD CONTROLLER%%%
%% I want
%Ts = 4 = 4/(zed*wn)
%OS = 10%
Ts = 4;
OS = 10;
zed_cl = -log(OS/100)/(sqrt(pi^2+log(OS/100)^2))
wn_cl = 4/(Ts*zed_cl) 
%%Zed_cl = 0.59116 - underdamped b/t 0 and 1
%%wn_cl = 1.69 - faster than before
kp = k - wn_cl^2*m
kd = c - 2*zed_cl*wn_cl*m
%%kp = -11.308
%%kd = -2

%%%SIMULATE THE CLOSED LOOP SYSTEM
CONTROL = 1;
[tout,xout] = ode45(@Derivs,[0 20],[0;0]);
figure()
plot(tout,xout)
K = [kp kd];
eig(A+B*K)

function dxdt = Derivs(t,x)
global CONTROL kp kd
m = 5;
c = 8;
k = 3;
A = [0 1;-k/m -c/m];
B = [0;1/m];
if CONTROL == 0
	u = 1; %%%Step input
else
	%kp = -11.308; -- use globals it's fancier
	%kd = -2;
	K = [kp kd];
	xc = [1;0];
	u = K*(x-xc);
end
dxdt = A*x + B*u;
