clear
clc
close all

global kp m

kp = 27;
m = 3;
w = sqrt(kp/m);
tout = linspace(0,10,100);

%%%ZPK
GZPK = zpk([],[0,0,i*sqrt(kp/m),-i*sqrt(kp/m)],[10.194*kp/m])
impulse(GZPK)

%%%TF
GTF = tf([10.194*kp/m],[1 0 kp/m 0 0])
impulse(GTF)

%%%SS
xinitial_ss = [0;0];
[tout_ss,xout_ss] = ode45(@Derivatives_ss,tout,xinitial_ss);

%%%ss2tf, tf2ss
A = [0 1;-kp/m 0];
B = [0;1];
C = [kp/m 0];
D = 0;
[num,dem] = ss2tf(A,B,C,D)
GFROMSS = tf(num,dem);
[Atf,Btf,Ctf,Dtf] = tf2ss(num,dem)

%%%%ODE45
xinitial = [0;0];
[tout_ode,xout_ode] = ode45(@Derivatives,tout,xinitial);

%%%ANALYTICAL
pc_analytical = 10.194*tout - 10.194/w*sin(w*tout);

%figure()
%pc_ss = C*z;
%pc_ss = [kp/m 0]*z
pc_ss = kp/m*xout_ss(:,1);
hold on
plot(tout_ss,pc_ss,'k-')
%hold on
plot(tout,pc_analytical,'r--')
plot(tout_ode,xout_ode(:,1),'g-')
xlim([0 10])