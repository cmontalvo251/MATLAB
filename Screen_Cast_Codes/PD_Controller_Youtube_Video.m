%%%% Spring Mass Damper System
function PD_controller_tuning()
global k m c kp kd
clc
close all

%%% m * xdbldot + c * xdot + k * x = f

%%% PD controller for f

%%% f = -kp * x + kd * xdot

%%%% xdbldot + (c + kd)/m * xdot + (k + kp)/m * x = 0

%%%% ^^^Closed loop system

%%%% Parameters - Problem 26 from Chapter 4 of Norman Nise 
%%%% Control System Engineering
m = 5;
c = 2;
k = 20;

%%% Open Loop
kp = 0;
kd = 0;

%%%% X * (s^2 + (c+kd)/m * s + (k+kp)/m ) = 0
%%%% ^^^assumes initial conditions - impulse response

%%%Natural Frequency and Damping Ratio
wn = sqrt((k+kp)/m)

%%% (s^2 + (c+kd)/m * s + (k+kp)/m )
%%% (s^2 + 2*zed*wn*s + wn^2)

%%% (c+kd)/m = 2*zed*wn
zed = ((c+kd)/m)/(2*wn)

%%%% Poles and Zeros
%%% -zed*wn +- wn*sqrt(1-zed^2)
s1 = -zed*wn + i*wn*sqrt(1-zed^2)
s2 = -zed*wn - i*wn*sqrt(1-zed^2)

denom = [1 (c+kd)/m (k+kp)/m];
roots(denom)
G = tf([wn^2],denom)
pzmap(G)

%%%%Overshoot
OS = exp(-(zed*pi/(sqrt(1-zed^2))))*100
%%%Settling Time
Ts = 4/(zed*wn)

%%%% Transfer Function - System
figure()
step(G)

%%%%I want OS = 15% and Ts = 0.7
%%% -sqrt(1-zed^2)*log(OS/100) = zed*pi
%%% (1-zed^2)*log(OS/100)^2 = zed^2*pi^2
%%% log(OS/100)^2 - zed^2*log(OS/100)^2 = zed^2*pi^2
%%% log(OS/100)^2 = zed^2*(pi^2 + log(OS/100)^2)
%%% log(OS/100)^2/(pi^2 + log(OS/100)^2) = zed^2
OS_closed_loop = 15
zed_cl = sqrt(log(OS_closed_loop/100)^2/(pi^2 + log(OS_closed_loop/100)^2))
OS_closed_loop = exp(-(zed_cl*pi/(sqrt(1-zed_cl^2))))*100
%%% Ts = 4/(zed*wn)
%%% zed*wn * Ts = 4
%%% wn = 4/(zed*Ts)
Ts_closed_loop = 0.7
wn_cl = 4/(zed_cl*Ts_closed_loop)

%%% s^2 + 2*zed*wn + wn^2
denom_cl = [1 2*zed_cl*wn_cl wn_cl^2]
roots(denom_cl)
s1_cl = -zed_cl *wn_cl + i*wn_cl*sqrt(1-zed_cl^2)
s2_cl = -zed_cl *wn_cl + i*wn_cl*sqrt(1-zed_cl^2)
G_cl = tf([wn_cl^2],denom_cl)
figure()
step(G_cl)
figure()
pzmap(G_cl)

%%%Determination of Kp
%%% m*wn_cl^2-k = kp
kp = m*wn_cl^2-k

%%%Determination of Kd
%%% m*2*zed_cl*wn_cl-c = kd
kd = m*2*zed_cl*wn_cl-c

%%%Finished Tuning my PD controller

%%%% State Space
%%%% xdbldot + c/m * xdot + k/m * x = f/m

%%%% xvec = [x;xdot]
%%%% xvecdot = [xdot;xdbldot] = [0 1;-k/m -c/m]*[x;xdot] + [0;1/m]*f
A = [0 1;-k/m -c/m]
B = [0;1/m]

%%%Poles of SS
eig(A)

%%%Poles of CL SS
%%% xvecdot = A*xvec + B*f
%%% f = B*K*xvec
%%% A_CL = (A+BK)
K = [-kp -kd];
A_CL = A + B*K
eig(A_CL)

[tout,xout] = ode45(@Derivatives,[0 1.2],[0;0]);

figure()
plot(tout,xout(:,1))


function xvecdot = Derivatives(t,xvec)
global k m c kp kd

A = [0 1;-k/m -c/m];
B = [0;1/m];
%kp = 0;
wn = sqrt((k+kp)/m);

%f = wn^2*m;

%%%%Let's add feedback
K = [-kp -kd];
f = K*xvec + m*wn^2;

xvecdot = A*xvec + B*f;






