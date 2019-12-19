%%%%
clear
clc
close all

X = [8;9;11];

Y = log10(X);

x0 = 9;

H = [ones(length(Y),1),(X-x0),(X-x0).^2]


astar = inv(H'*H)*H'*Y

ytilde = H*astar;

plot(X,Y,'b*')
hold on
plot(X,ytilde,'r--')

a0= astar(1);
a1 = astar(2);
a2 = astar(3);

x = 10;

estimate = a0 + a1*(x-x0) + a2*(x-x0)^2

a_sol = 1;

error = a_sol - estimate