clear
clc
close all

A = [1 1 2;-2 -2 -4;2 4 5];
B = [2;4;5];

%%% A*v = B -> v = [x;y;z]

det(A) %%solution exists

rref([A B])

x = -2:0.1:2;
y = -2:0.1:2;

[x,y] = meshgrid(x,y);

z1 = (2-x-y)/2;
z2 = (4+2*x+2*y)/(-4);
z3 = (5-2*x-4*y)/5;

figure()

mesh(x,y,z1,'FaceColor','r','EdgeColor','r')
hold on
mesh(x,y,z2,'FaceColor','g','EdgeColor','g')
mesh(x,y,z3,'FaceColor','b','EdgeColor','b')
plot3(-0.375,-0.125,1.25,'ks','MarkerSize',10)

