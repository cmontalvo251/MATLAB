function y = falseposition()
close all
%%%Initial guess
t1 = 1;
%%%Initial timestep
dt = 0.5;
t2 = t1 + dt;
%%%Initial Function Value
f1 = myfunc(t1);
f2 = myfunc(t2);
%%%Set an error threshold
threshold = 1e-2;
%%%%Save the number of iterations and the value at each iteration and the
%%%%time at each iteration
iterations = [];
t = [];
y = [];
idx = 0;
fr = f1;
%%%%Loop while error is greater than threshold
while abs(fr-0) > threshold
    %%%Compute tr based on f1 and f2
    tr = t2 - f2*(t1-t2)/(f1-f2);
    fr = myfunc(tr);
    %%%Save state
    idx = idx+1;iterations = [iterations;idx];
    t = [t;tr];
    y = [y;fr];
    %%%%Test to see which bound we will replace
    if sign(fr) == sign(f1)
        t1 = tr;
    else
        t2 = tr;
    end
end

function y = myfunc(t)

V = 10;
theta = pi/4;
vy = V*sin(theta);
a = -9.81;
y = vy*t + (1/2)*a*t.^2;