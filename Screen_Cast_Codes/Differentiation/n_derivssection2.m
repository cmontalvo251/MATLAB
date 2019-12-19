%%%% y = 4*x^3 + 3*x^2
clear
clc
close all
x = 0:0.1:5;

y = 4*x.^3 + 3*x.^2;

%%%% dydx = 12*x^2 + 6*x

dydx = 12*x.^2 + 6*x;

plot(x,dydx)


%%%Forward Differencing

%%%Multiple Points
y_n = zeros(1,length(x));
dx = 0.001;
for marquez = 1:length(x)
    x1 = x(marquez) + dx;
    fx = 4*x(marquez)^3 + 3*x(marquez)^2;
    fx1 = 4*x1^3 + 3*x1^2;
    y_n(marquez) = (fx1-fx)/dx;
end

hold on
plot(x,y_n,'r-')






%%%%Single Point
xi = 2;
dx = 0.001;

a_sol = 12*xi^2 + 6*xi

fxi1 = 4*(xi+dx)^3 + 3*(xi+dx)^2; %%%Function evaluated at xi+dx
fxi = 4*xi^3 + 3*xi^2;

n_sol = (fxi1 - fxi)/dx















