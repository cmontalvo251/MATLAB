clear
clc
close all

A = tf([1],[1,1])
G = tf([1],[1,1])
H = tf([1],[1,1])
C = tf([1,3],[1])

GOL = C*A*G*H;

bode(GOL)
margin(GOL)

figure()
rlocus(GOL)

K = 5000;

GCL = K*GOL/(1+K*GOL);

figure()
step(GCL)