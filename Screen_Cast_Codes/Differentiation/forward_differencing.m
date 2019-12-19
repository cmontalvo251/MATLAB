clear
clc
close all

delx = 1;

x = -pi:delx:pi;

y = sin(x);

fig = figure();
set(fig,'color','white')
plot(x,y,'LineWidth',2)
xlabel('x')
ylabel('y')
grid on

yderiv = cos(x);

fig = figure();
set(fig,'color','white')
plot(x,yderiv,'LineWidth',2)
xlabel('x')
ylabel('y')
grid on

%%%%Use Forward differencing to compute the value of yderiv numerically
yderivest = (y(2:end) - y(1:end-1))./delx;

hold on
plot(x(2:end)-delx/2,yderivest,'r-','LineWidth',2)

legend('Analytical Derivative','Numerical Derivative')