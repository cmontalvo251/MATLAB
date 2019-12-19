close all
clear
clc

x = [5 5 -5 -5 5];
y = [-5 5 5 -5 -5];
z1 = ones(1,length(x));

plot3(x,y,z1)

hold on

z2 = z1 - 2;

plot3(x,y,z2)

xx = [x;x];
yy = [y;y];
zz = [z1;z2]; %%%Concatenate my vectors together to make matrices

mesh(xx,yy,zz)



axis([-10 10 -10 10])