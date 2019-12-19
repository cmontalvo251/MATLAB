clear
clc
close all


X = [1;2;3;4]; %%%Change to Angle of attack

Y = [4;4;3;1]; %%%Change to drag points (CD)


fig = figure();
set(fig,'color','white')
set(gca,'FontSize',18)
plot(X,Y,'b*','MarkerSize',10)
grid on
xlabel('X')
ylabel('Y')

H = [ones(length(X),1),(X).^2];
Astar = inv(H'*H)*H'*Y %%%This is [Cd0;Cda]
Ytil = H*Astar;

Sr = sum((Y-Ytil).^2);
St = sum((Y-mean(Y)).^2);
r = sqrt((St-Sr)/St)

Xnew = linspace(X(1),X(end),100)';
Hnew = [ones(length(Xnew),1),(Xnew).^2];
Ytilde = Hnew*Astar;

hold on
plot(Xnew,Ytilde,'r-','LineWidth',2)
