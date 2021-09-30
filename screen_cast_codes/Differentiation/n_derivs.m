clear
clc
close all


%%%%y = e^(-2x)


%%%dydx = -2e^(-2x)


x = 0:0.1:10;

y = exp(-2*x);

dydx_a = -2*exp(-2*x);


figure()
plot(x,y)


figure()
plot(x,dydx_a)

y_n = zeros(length(x),1);
dx = 0.1;
for ii = 1:length(x)
    x1 = x(ii);
    x2 = x1 + dx;
    y1 = exp(-2*x1)+rand*0.1;
    y2 = exp(-2*x2)+rand*0.1;
    y_n(ii) = (y2-y1)/dx;
end

hold on
plot(x,y_n,'r-')

%%%%Derivative at x = 5
x = 0.5;
a_sol = -2*exp(-2*x)

%%%Forward differencing
x1 = x;

x2 = x+dx;

y1 = exp(-2*x1);
y2 = exp(-2*x2);


n_sol = (y2-y1)/(dx)
