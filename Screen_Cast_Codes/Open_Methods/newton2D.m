function newton2D()

clc
close all


x = -5:0.1:5;
y = -5:0.1:5;

[xx,yy] = meshgrid(x,y);

zz = f(xx,yy);

mesh(xx,yy,zz)

%%% f = 0

hold on

r0 = [-1;1]; %%initial guess on x is 10 and my initial guess on y is 10
alfa = 0.1;
while abs(f(r0(1),r0(2))) > 1e-5
    r0 = r0 - alfa*f(r0(1),r0(2))./fprime(r0(1),r0(2));
    plot3(r0(1),r0(2),f(r0(1),r0(2)),'rs','MarkerSize',20)
end

r0
f(r0(1),r0(2))



theta = linspace(0,2*pi,100);
r = 5;
xc = r*cos(theta);
yc = r*sin(theta);

%plot3(xc,yc,0*xc,'r-','LineWidth',5)

hold on

%%%Find the minimum
r0 = [2;2]; %%initial guess on x is 10 and my initial guess on y is 10
alfa = 0.1;
for index = 1:1000
    plot3(r0(1),r0(2),f(r0(1),r0(2)),'r*','MarkerSize',20)
    r0 = r0 - alfa*inv(fdblprime(r0(1),r0(2)))*fprime(r0(1),r0(2));
end

r0
f(r0(1),r0(2))


function z = f(x,y)

%z = (x+2).*(x-2).*(x-4).*(x+4) + y.^2;
%z = (x.^2 - 4).*(x.^2-16) + y.^2;
z = x.^4 - 20.*x.^2 + 64 + y.^2;

function zprime = fprime(x,y)
%%Gradient which is a vector

dfdx = 4*x.^3 - 40*x;
dfdy = 2*y;

zprime = [dfdx;dfdy];

function zdblprime = fdblprime(x,y)
%Jacobian which is a matrix
df2dx2 = 12*x.^2 - 40;
df2dxdy = 0;
df2dy2 = 2;
df2dydx = 0;

zdblprime = [df2dx2 df2dxdy ; df2dydx df2dy2];


