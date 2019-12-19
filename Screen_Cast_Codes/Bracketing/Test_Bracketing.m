clear
clc
close all

yb = abs(bisection);

yf = abs(falseposition);

plottool(1,'Name',12,'Iteration Number','|E|');

plot(yb,'b-','LineWidth',2)
plot(yf,'r-','LineWidth',2)

legend('Bisection Method','False Position Method');