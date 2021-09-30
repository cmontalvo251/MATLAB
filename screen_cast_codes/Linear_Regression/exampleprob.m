clear
clc
close all


X = [1;2;3;4];

Y = [4;4;3;1];


fig = figure();
set(fig,'color','white')
set(gca,'FontSize',18)
plot(X,Y,'b*','MarkerSize',10)
grid on
xlabel('X')
ylabel('Y')

x0 = 2;


H = [ones(length(X),1),X-x0,(X-x0).^2];


Astar = inv(H'*H)*H'*Y;

Ytil = H*Astar;

Sr = sum((Y-Ytil).^2)
St = sum((Y-mean(Y)).^2)
r = sqrt((St-Sr)/St)

Xnew = linspace(1,4,100)';
Hnew = [ones(length(Xnew),1),Xnew-x0,(Xnew-x0).^2];

Ytilde = Hnew*Astar;

hold on
plot(Xnew,Ytilde,'r-','LineWidth',2)

plot(Xnew(80),Ytilde(80),'r*','MarkerSize',20)