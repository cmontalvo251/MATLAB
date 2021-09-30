function lagrange_polynomials()

clear
clc
close all

%%%Actual Function
x = linspace(-5,5,50);
y = f(x);

figure()
plot(x,y,'r--','LineWidth',2)
grid on
hold on

%%%Sample Data Points
x0 = 2;
fx0 = f(x0);
x1 = 4;
fx1 = f(x1);
x2 = 3; 
fx2 = f(x2);

plot(x0,fx0,'b*','MarkerSize',10)
plot(x1,fx1,'b*','MarkerSize',10)
plot(x2,fx2,'b*','MarkerSize',10)

%%Linear Lagrange Polynomial

% L11 = (x-x1)/(x0-x1)*fx0;
% L12 = (x-x0)/(x1-x0)*fx1;
% L1 = L11+L12;

% plot(x,L11,'g-.','LineWidth',2)
% plot(x,L12,'g--','LineWidth',2)
% plot(x,L1,'g-','LineWidth',2)

%%%Quadratic Lagrange Polynomial
L21 = (x-x1).*(x-x2)/((x0-x1)*(x0-x2))*fx0;
L22 = (x-x0).*(x-x2)/((x1-x0)*(x1-x2))*fx1;
L23 = (x-x0).*(x-x1)/((x2-x1)*(x2-x0))*fx2;

L2 = L21+L22+L23;

plot(x,L21,'b--','LineWidth',2)
plot(x,L22,'b--','LineWidth',2)
plot(x,L23,'b--','LineWidth',2)
plot(x,L2,'b-','LineWidth',3)
ylim([-20 20])


%%%%Estimate 
xest = 3;
yactual = f(xest);

plot(xest,yactual,'k*','MarkerSize',12)

% L1est = (xest-x1)/(x0-x1)*fx0 + (xest-x0)/(x1-x0)*fx1;

% plot(xest,L1est,'k*','MarkerSize',12)
function y = f(x)

y = sin(x);