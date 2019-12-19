%%%Simple Interpolation method
%%%Curve fitting method
%%%Taylor Series - Orders

function lagrangepoly()

clc
clear

x = 0:0.1:4;

y = f(x);

close all

plot(x,y,'k-','LineWidth',2)
hold on
grid on

%%%Sampled Data Points
x0 = 0;
y0 = f(x0);
x1 = 2;
y1 = f(x1);
x2 = 4;
y2 = f(x2);

%%%%Linear Version
%L1 = (x-x1)/(x0-x1)*y0;
%L2 = (x-x0)/(x1-x0)*y1;
%Llinear = L1+L2;

%%%Quadratic Version
L1 = (x-x1).*(x-x2)/((x0-x1)*(x0-x2))*f(x0);
L2 = (x-x0).*(x-x2)/((x1-x0)*(x1-x2))*f(x1);
L3 = (x-x0).*(x-x1)/((x2-x0)*(x2-x1))*f(x2);
Lquad = L1+L2+L3;

%plot(x,L1,'r-','LineWidth',2)
%plot(x,L2,'b-','LineWidth',2)
%plot(x,L3,'g-','LineWidth',2)
plot(x,Lquad,'m-','LineWidth',2)
%legend('Truth','L1','L2','L3','Lquad')

xsamples = [x0 x1 x2 1 3 0.5];
fsamples = f(xsamples);

fxn = Lpoly(x,xsamples,fsamples,5);

plot(x,fxn,'r-','LineWidth',2)

legend('Truth','Lagrange Explicit','Lagrange Computed')

function y = f(x)

y = sin(x);
