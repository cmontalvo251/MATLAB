%%%%%Estimate log10(10)
clear
clc
close all

%%%Analytical Solution
a_sol = 1;

%%%Given Data Points
X = [8;9;11];
Y = log10(X);

figure()
plot(X,Y,'b*')
grid on
hold on

%%%%Polynomial Fit 
%%%I have three data points so I can only solve for three coefficients
%%%% Y = a0 + a1*(X-x0) + a2*(X-x0)^2 
%%%  Unknowns are a0 a1 and a2 

%%%% This polynomial is second order

%%%% Y = H*A where A = [a0;a1;a2]

%%% Y = [y1 y2 y3]'

%%%Choose an expansion point
x0 = 9;

%%%%%Generate my H matrix
H = [ones(length(Y),1),X-x0,(X-x0).^2];

%%%Use Carl Gauss' magical equation
astar = inv(H'*H)*H'*Y;

%%%Compute ytilde
X = (8:0.01:11)';
H = [ones(length(X),1),X-x0,(X-x0).^2];
Ytilde = H*astar;

plot(X,Ytilde,'r--')

%%%Compute my estimate at x=10
a0 = astar(1);
a1 = astar(2);
a2 = astar(3);

x = 10;

yest = a0 + a1*(x-x0) + a2*(x-x0)^2;

plot(x,yest,'rs')

plot(x,a_sol,'g*')



