function bisectionSectionI()
close all

x = -pi:0.1:pi;

fx = myfunc(x);

plot(x,fx);

x0 = 0;

f0 = myfunc(x0); %%%Is negative

dx = 2;

x1 = x0 + dx;

f1 = myfunc(x1); %%%Is positive

err = abs(f1);

threshold = 0.0001;

dx = -dx/2;
x = x1;
f0 = f1;
itermax = 100;
iter = 0;
while err > threshold && iter < itermax
    
    x = x + dx;
    
    f1 = myfunc(x);
    
    if sign(f1) ~= sign(f0)
        %%%Changed signs
        dx = -dx/2;
    end
    f0 = f1;
    
    err = abs(f0);

    iter = iter  + 1
end

x
f0

err


function out = myfunc(in)

out = 5 - 8*cos(in);