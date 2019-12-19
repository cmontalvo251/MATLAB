function second_order()
clc
close all

delx = 0.0001;
x1 = -10:delx:10;
x0 = x1 - delx;
x2 = x1 + delx;

%%%First Derivative
dy = cos(x1);

plot(x1,dy,'b-','LineWidth',2)
hold on

fx0 = f(x0);
fx1 = f(x1);
fx2 = f(x2);

fprime1_F = (fx2-fx1)/delx;

plot(x1,fprime1_F,'r--','LineWidth',2)

fprime1_B = (fx1-fx0)/delx;

plot(x1,fprime1_B,'g--','LineWidth',2)

%fprime1_C = (fx2-fx0)/(2*delx);
fprime1_C = (fprime1_F+fprime1_B)/2;

plot(x1,fprime1_C,'k--','LineWidth',2)

%%%Second Derivative
d2y = -sin(x1);

%fdblprime = (2/delx^2)*(fx2-fx1-fprime1_C*delx);
fdblprime = (fx2-2*fx1+fx0)/delx^2;

figure()
plot(x1,d2y,'b-','LineWidth',2)
hold on
plot(x1,fdblprime,'r--','LineWidth',2)
legend('Actual','Approximation')

function out = f(x)

out = sin(x);