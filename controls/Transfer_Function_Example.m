clear
clc
close all


X = zpk([-3],[-1 -4],[2])
step(X)

figure()
Y = zpk([-3],[0 -1 -4],[2])
impulse(Y)