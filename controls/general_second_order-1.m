clear
clc
close all

m = 2;
k = 10;

wn = sqrt(k/m)

%ccritical = 2*m*wn

c = 3;

zed = (c/(2*m*wn))

denom = [1 c/m k/m];
roots(denom)
G = tf([k/m],denom)

hold on
step(G)

figure()
pzmap(G)
