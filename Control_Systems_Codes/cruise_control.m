clear
clc
close all


%%%Open Loop Dynamics
fig = figure();

GOL = tf([1],[1 5]);

step(GOL)

a = gca;
set(a,'FontSize',18)
ylabel('Velocity (m/s)','FontSize',18)
xlabel('Time(Sec)','FontSize',18)


%%%Closed Loop Dynamics
K = 200;

fig2 = figure();

GCL = tf([15*K],[1 20 75+15*K]);
step(GCL)
a = gca;
set(a,'FontSize',18)
ylabel('Velocity (m/s)','FontSize',18)
xlabel('Time(Sec)','FontSize',18)

%%%Steady State Error

K = 1:100;

ess = 1-15*K./(75+15*K);

figure()
plot(K,ess)

