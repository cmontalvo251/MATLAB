clear
clc
close all

%###Inertia Calculation
a = 10/100.;
m = 3;
I = (m/12.)*(a^2+a^2);
disp(I);
%###Plant Dynamics
G = tf([1],[0.003,0,0])

%###Actuator Dynamics
time_constant = 1/1.316
sig = 1/time_constant;
A = tf([sig],[1,sig])

%###Sensor Dynamics
time_constantH = 1/1000.
sigH = 1/time_constantH;
H = tf([sigH],[1,sigH])

%###Open Loop System
GOL = A*G*H

bode(GOL)
margin(GOL)
hold on

%##Design your compensator
C = zpk([-1,-1.1,-5],[-4000,-9000,1],1)

%###Plant with Compensation
GC = C*GOL
bode(GC)
[gm,pm,wgm,wpm]=margin(GC);

figure()
rlocus(GC)

%%%Closed Loop System
k = 1.9e6;
GCL = k*GC/(1+k*GC)

figure()
step(GCL)

