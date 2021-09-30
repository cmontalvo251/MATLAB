%%%%SIMPSONS 1/3 RULE

%%%%%y = cos(x) from  0 to pi/2
clear
clc
close all

x = linspace(0,pi/2,100);

y = cos(x);

plot(x,y)

xi = 0;
I = 0;
dx = 0.01;
while xi <= (pi/2)
    %%%fxi is function at xi
    %%%fx2i is function at xi + dx/2
    %%%fxdi is function at xi + dx
    fxi = cos(xi);
    fx2i = cos(xi+dx/2);
    fxdi = cos(xi+dx);
    I = I + (1/6)*(fxi + 4*fx2i + fxdi)*dx;
    xp = [xi xi+dx/2 xi+dx xi+dx xi+dx/2 xi];
    yp = [0   0       0     fxdi fx2i    fxi];
    patch(xp,yp,[0 1 1])
    hold on
    drawnow
    xi = xi + dx;
end
I 