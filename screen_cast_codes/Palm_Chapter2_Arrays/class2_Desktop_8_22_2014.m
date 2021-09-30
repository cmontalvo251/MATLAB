close all
clear
clc

disp('Hey the script worked')

%%%Problem 2 in class
%%Solve y = x^5.....

c = [1 4 1 -3 0 0];

r = roots(c);

disp('Roots = ')
disp(r)

x = -3:0.1:3;

y = c(1)*x.^5 + c(2)*x.^4 + c(3)*x.^3 + c(4)*x.^2;

plot(x,y)