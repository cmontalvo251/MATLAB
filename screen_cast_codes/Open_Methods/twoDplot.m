function twoDplot()
clear
clc
close all

maxIter = 100;
alfa = 1;
x0 = 10;

for ii = 1:maxIter
    x0 = x0 - alfa*f(x0)/fprime(x0);
end

x0 

y = -10:0.1:10;

[xx,yy] = meshgrid(x,y);

zz = xx.^2 + yy.^2-10^2;

figure()

mesh(xx,yy,zz)

%%% x^2 + y^2 = r^2
r = 10;
theta = linspace(0,2*pi,100);
yc = r*sin(theta);
xc = r*cos(theta);

hold on

plot3(xc,yc,0*xc,'LineWidth',5)

r0 = [-10;-10];
alfa = 0.1;

for ii = 1:maxIter
    ff(r0)
    ffprime(r0)
    r0 = r0 - alfa*ff(r0)./ffprime(r0);
end

plot3(r0(1),r0(2),0,'rs','MarkerSize',10)

r0 = [-10;-10];

for ii = 1:maxIter
    r0 = r0 - alfa*inv(ffdblprime(r0))*ffprime(r0);
end

plot3(r0(1),r0(2),ff(r0),'ys','MarkerSize',10)


function z = ff(r0)
x = r0(1);
y = r0(2);
z = x.^2 + y.^2 - 10^2;

function zprime = ffprime(r0)
x = r0(1);
y = r0(2);
zprime = [2*x ; 2*y]; %%Vector?
%%%zprime = [df/dx ; df/dy]

function zdblprime = ffdblprime(r0)
x = r0(1);
y = r0(2);
zdblprime = [2 0;0 2];

%%% zdblprime = [d^2f/dx^2 d^2f/dxdy ; 
%%d^2f/dydx d^2f/dx^2]

function y = f(x)
y = 5*x + 4;

function yprime = fprime(x)
yprime = 5;

