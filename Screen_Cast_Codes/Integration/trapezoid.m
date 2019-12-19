%%%%% y = atan(x) from -1 to 1
clear
clc
close all
x = -1:0.1:1;
y = atan(x);

plot(x,y)

xi = -1;
dx = 0.01;
I = 0;
while xi <= 1 - dx
    
    %%%%Function evaluated at the original x value
    fxi = atan(xi);
    %%%%Function evaluated at the next value xi + dx
    fx2i = atan(xi+dx);

    I = I + (1/2)*(fx2i+fxi)*dx;
    
    xp = [xi xi+dx xi+dx xi];
    yp = [0   0     fxi fx2i];
    patch(xp,yp,[1 1 0])
    drawnow

    xi = xi + dx;
end

I
