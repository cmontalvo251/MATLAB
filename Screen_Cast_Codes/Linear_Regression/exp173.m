%%%% Example 17.3
clear
clc
close all

%%GIVEN    
X = [0 2 4 6 9 11 12 15 17 19]';       
Y = [5 6 7 6 9 8 7 10 12 12]';

H = [ones(length(X),1),X];

Astar = inv(H'*H)*H'*Y;

Ytilde = H*Astar;

plot(X,Y,'b*')
hold on
plot(X,Ytilde,'r--')


figure()
R = (Ytilde-Y).^2;
plot(R,'b*')
Rtotal = sum(R);