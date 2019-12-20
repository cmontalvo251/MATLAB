%%%%First order
close all
clear
clc

%%% ydot + tau*y = f

tau = 62;
f = 42;


%%%Using MATLAB to Solve for y
%Y = tf([f],[1 tau 0])
%impulse(Y)
Y = zpk([],[0 -tau],[f])
impulse(Y)

%%%Analytical solution
t = linspace(0,0.1,100);
y_analytical = (f/tau)*(1-exp(-tau*t));
hold on
plot(t,y_analytical,'r-')

