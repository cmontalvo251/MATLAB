clear
clc
close all

X = (1:5)';
Y = X.^2;


fig = figure();
set(fig,'color','white')
grid on
hold on
plot(X,Y,'bs')

%%%Assume y = a0
H = [ones(length(X),1)];
astar = inv(H'*H)*H'*Y;
a0 = astar;

%%Recompute ytilde
%ytilde = a0*ones(length(X),1);
ytilde = polyval(astar,X);

plot(X,ytilde,'r--')

%%%Assume y = a0 + a1*x
H = [ones(length(X),1),X];
astar = inv(H'*H)*H'*Y;
a0 = astar(1);
a1 = astar(2);

%ytilde = a0 + a1*X;
ytilde = polyval(astar(end:-1:1),X);

plot(X,ytilde,'g--')

%%%Assume y = a0 + a1*x + a2*x^2
H = [ones(length(X),1),X,X.^2];
astar = inv(H'*H)*H'*Y;
a0 = astar(1);
a1 = astar(2);
a2 = astar(3);

%ytilde = a0 + a1*X + a2*X.^2;
ytilde = polyval(astar(end:-1:1),X);

plot(X,Y,'m--','LineWidth',2)


















