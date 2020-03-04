clear
clc
close all

G = tf([5],[10,1,0])

tout = linspace(0,200,1000);

yout = step(G,tout);

plot(tout,yout)

C = 1/200;

GCL = minreal(C*G/(1+C*G))

yout_CL = step(GCL,tout);

figure()
plot(tout,yout_CL)

