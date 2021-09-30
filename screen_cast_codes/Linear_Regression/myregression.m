close all
clear
clc


X = [0 1]';
Y = [3 4]';


fig = figure();
set(fig,'color','white')
grid on
hold on
plot(X,Y,'bs')

%%%Assume that y = a0
H = [ones(length(Y),1)];
astar = inv(H'*H)*H'*Y;
a0 = astar

%%%%Recompute ytilde
ytilde = a0*ones(length(X),1);
plot(X,ytilde,'r--')

%%%Assume that y = a0 + a1*x
H = [ones(length(Y),1),X];
astar = inv(H'*H)*H'*Y;
a0 = astar(1);
a1 = astar(2);

%%%Reompute Ytilde
ytilde = a0 + a1*X;
plot(X,ytilde,'g--')

















