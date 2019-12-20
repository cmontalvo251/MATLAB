%%%%%Second Order System
clear
clc
close all


k = 2;
m = 1;


%%%No damped Case
c = 0;

G = tf([1/m],[1 c/m k/m])

%%%Generate Pole Zero Map
pzmap(G)

%%%Generate Step Response
figure()
step(G)

%%%Critically Damped Case
c = sqrt(4*k*m);

G = tf([1/m],[1 c/m k/m])

%%%Generate Pole Zero Map
figure()
pzmap(G)

%%%Generate Step Response
figure()
step(G)