function ystar = onedinterp(xstar)
clc
close all

X = (1:4)';
Y = [4;4;3;1];

figure()

plot(X,Y,'b*')

%%%%%Given 

%%%Find y0,y1,x1,x0
loc = find(xstar < X,1)
x1 = X(loc)
x0 = X(loc-1)
y1 = Y(loc)
y0 = Y(loc-1)

m = (y1-y0)/(x1-x0);
ystar = y0 + m*(xstar - x0)
hold on
plot(xstar,ystar,'r*','MarkerSize',10)
