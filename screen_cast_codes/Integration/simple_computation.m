function simple_computation
close all

N1 = 4;

x = linspace(0,10,N1+1)

x(end) = []; %%%Then last coordinate empty

fx = DrC(x);

plot(x,fx)

dx = x(2)-x(1);

%%%for idx = 1:length(x) - 1

%%%% while xi <= xend - dx


%%%%Reimmann
I = sum(fx)*dx

%%%Trapezoidal
fx1 = DrC(x+dx);
I = sum(fx+fx1)*0.5*dx


function out = DrC(in)


out = 4*in;