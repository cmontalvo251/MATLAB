clear
clc
close all

%%%%Visualize Phase Lines
alfa = -2; 

%%%%alfa > 0, 1 eq , 1 stable

%%%%alfa < 0, 3 eq , 2 stable 1 unstable

xdot = linspace(-2,2,100);
x = linspace(-2,2,100);

bata = 1;
c = 2;
figure()
hold on

[xxdot,xx] = meshgrid(xdot,x);

xxdbldot = -c*xxdot - alfa*xx - bata*xx.^3;

mesh(xx,xxdot,xxdbldot)


    

