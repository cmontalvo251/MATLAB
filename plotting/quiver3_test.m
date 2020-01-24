clear
clc
close all

x = -10:10;
y = -10:10;
z = -10:10;

[xx,yy,zz] = meshgrid(x,y,z);

uu = 0.*xx + 5;
vv = 0.*xx + -3;
ww = 10*sin(2*xx);

quiver3(xx,yy,zz,uu,vv,ww)


t = linspace(0,2*pi,100);
x = 5*cos(t);
y = 5*sin(t);
z = 10*t;

u = -1*cos(t);
v = -1*sin(t);
w = u*0 + 3;

figure()
quiver3(x,y,z,u,v,w)