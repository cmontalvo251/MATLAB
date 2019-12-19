%%%%Mode shapes of a rectangle
clear
close all
clc

%%%Size of the plate
a = 1;
b = 1;
%%%Mode shape
m = 3;
n = 3;
%%%Magnitude
A = 1;
%%%x and y modes
x = linspace(0,a,100);
y = linspace(0,b,100);
[xx,yy] = meshgrid(x,y);
phix = sin(m*pi*xx/a);
phiy = sin(n*pi*yy/b);
%%%displacement / deflection
w = 1; %%some frequency whatever I want

zzconst = A*phix.*phiy;
mesh(xx,yy,zzconst)

figure()
for t = 1:0.1:100
    cla;
    zz = A*phix.*phiy*sin(w*t);
    mesh(xx,yy,zz)
    axis([0 a 0 b -A A])
    view(45,45)
    drawnow
end

