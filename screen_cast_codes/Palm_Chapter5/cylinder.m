clear
clc
close all


theta = linspace(0,2*pi,100);

xx = [];
yy = [];
zz = [];
ridx = 2;
x = ridx*cos(theta);
y = ridx*sin(theta);
z = ones(1,length(x))+ridx;
xx = [x;x];
yy = [y;y];
zz = [z;z+2];
mesh(xx,yy,zz)


%%%%2-D Surface
% x = -10:0.1:10;
% y = -10:0.1:10;
% [xx,yy] = meshgrid(x,y);
% zz = sin(1*xx.*yy);
% mesh(xx,yy,zz)