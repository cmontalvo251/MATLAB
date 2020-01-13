function steady_state_error()
clc
close all

m = (3000/2.2);
c = 500;
%%%%%Open Loop
G = tf(1/m,[1 c/m])
figure()
step(G)


%%%%Closed Loop Proportional Control
kp = 100;
G_CL_kp = tf(kp/m,[1 (kp+c)/m])
figure()
step(G_CL_kp)

%%%%Closed Loop Integral Control
ki = 100;
G_CL_kp_ki = tf([kp ki],[m c+kp ki])
figure()
step(G_CL_kp_ki)



