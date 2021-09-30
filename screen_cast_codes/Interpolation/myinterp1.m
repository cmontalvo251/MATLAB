function ystar = myinterp1(xstar)
clc
close all


X = [1;2;3;4];
Y = [4;4;3;1];

fig = figure();
set(fig,'color','white')
set(gca,'FontSize',18)
plot(X,Y,'b*','MarkerSize',10)
xlabel('X')
ylabel('Y')
grid on

%%%Find x0,x1,y0,y1

%%% x0 <= xstar <= x1

loc = find(xstar < X,1);
xstar
x1 = X(loc)
x0 = X(loc-1)
y1 = Y(loc);
y0 = Y(loc-1);

m = (y1 - y0)/(x1-x0);

ystar = y0 + m*(xstar - x0)
hold on
plot(xstar,ystar,'r*','MarkerSize',20)