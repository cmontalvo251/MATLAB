function bracketing()
clear
clc
close all

x = -1:0.1:1;

y = 8 - 9*cos(x);

plot(x,y)

grid on

%x = ginput;

%x1 = x(2);
%x0 = x(1);

%dx =x1-x0;

%%%%%%Later add ginput
x0 = -0.6;
dx = 0.4;
f0 = ex(x0);
err = abs(f0);
threshold = 1e-4;
iter = 0;
while err > threshold
    
    %%%Step forward
    x0 = x0 + dx;
    %%%Evaluate the function 
    f1 = ex(x0);
    
    %%%if f1 is negative or rather opposite sign to f0
    if sign(f1) ~= sign(f0)
        dx = -dx;
    end
    f0 = f1; %%%Reset our bounds
    dx = dx/2;
    
    %%%Recompute err
    err = abs(f0);
    
    iter = iter + 1;
    
end

x0
err
iter



function out = ex(in)

out = 8-9*cos(in);