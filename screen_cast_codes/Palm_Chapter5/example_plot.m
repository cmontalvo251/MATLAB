clear
clc
close all

x = -5:0.1:5;

y  = x.*x;

fig = figure();
set(fig,'color','white')
set(axes,'FontSize',18)
%plot(x,y,'cd--','LineWidth',3)
plot(x,y,'k-','LineWidth',3)
xlabel('x')
ylabel('y')
title('Awesome Graph')
grid on
hold on %%%Holds figure to plot multiple line
plot(x,2*x,'g-','LineWidth',2)
%%%The intersection of 2*x and x^2
xintersect = 2;
yintersect = 4;
plot(2,4,'ms','MarkerSize',10)
legend('y = x^2','y=2x')