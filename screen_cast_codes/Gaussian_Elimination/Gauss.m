

clear
clc
close all

x = -4:4;

y1 = (1-2*x)/2;
y2 = 1-x;

plottool(1,'Name',18,'x','y','z');
%plot(x,y1,'b-','LineWidth',2)
%plot(x,y2,'r-','LineWidth',2)

A = [1 1 2;-2 -2 -4;2 4 5];
det(A)
B = [2;4;5];
AB = [A,B];

C = rref(AB)

sol = C(:,4);

x = -2:0.1:2;
y = -2:0.1:2;
[xx,yy] = meshgrid(x,y);

z1 = (B(1)-A(1,1)*xx-A(1,2)*yy)/A(1,3);
z2 = (B(2)-A(2,1)*xx-A(2,2)*yy)/A(2,3);
z3 = (B(3)-A(3,1)*xx-A(3,2)*yy)/A(3,3);

mesh(xx,yy,z1,'EdgeColor','r','FaceColor','r')
mesh(xx,yy,z2,'EdgeColor','g','FaceColor','g')
mesh(xx,yy,z3,'EdgeColor','b','FaceColor','b')
%plot3(sol(1),sol(2),sol(3),'ks','MarkerSize',10)
%ball(sol(1),sol(2),sol(3),0.3)
