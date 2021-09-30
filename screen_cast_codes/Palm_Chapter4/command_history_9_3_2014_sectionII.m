cd 9_3_2014/
ls
clear
clc
exp(1)
num2str(ans)
length(ans)
format long g
exp(1)
num2str(ans)
length(ans)
num2str(2.71828182845905)
length(ans)
str = '2.71828182845905'
length(str)
A = [3 2 4;1 5 -3;4 -10 0];
B = [11 0 -3;5 -12 4;2 3 1];
A
B
A./B
format short
A
B
A./B
A/B
A*inv(B)
A*(B^(-1))
nrt
nsqrt
help sqrt
nthroot
nthroot(516)
nthroot(516,6)
516^(1/6)
help nthroot
clear
clc
c = [5 2 -5 -20]
roots(c)
r = ans(1)
5*r^3 + 2*r^2 - 5 *r - 20
help polyval
fig = figure('Name','Test')
fig2 = figure('Name','Test2')
x = linspace(-pi/2,pi/2,1000);
y = sin(x);
plot(x,y)
y = sin(x)+cos(x).^2;
plot(x,y)
y = 5*x.^3 + 2*x.^2 - 5*x - 20;
r = [5 2]
r^2
r.^2
y = 5*x.^3 + 2*x.^2 - 5*x - 20;
plot(x,y)
y = 5*x.^3 + 2*x.^2 - 5*x - 20;
c_13 = [5 2 -5 -20];
x_14 = -2:0.1:2;
r_13 = roots(c_13)
y_14 = polyval(c_13,x_14);
plot(x_14,y_14)
theta = linspace(0,2*pi,100);
y = sin(theta):
y = sin(theta);
x = cos(theta);
plot(x,y)