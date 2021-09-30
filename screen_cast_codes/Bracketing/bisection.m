function y = bisection()
close all
%%%Initial guess
ti = 1;
%%%Initial timestep
dt = 0.5;
%%%Initial Function Value
f1 = myfunc(ti);
f2 = f1;
%%%Set an error threshold
threshold = 1e-2;
%%%%Save the number of iterations and the value at each iteration and the
%%%%time at each iteration
iterations = [1];
t = [ti];
dti = [dt];
y = [f1];
phi = (1+sqrt(5))/2;
%%%%Loop while error is greater > threshold
while abs(f1-0) > threshold
    %%%Step forward until function changes sign
    while sign(f2) == sign(f1)
       ti = ti+dt; 
       f2 = myfunc(ti);
       iterations = [iterations;iterations(end)+1];
       t = [t;ti];
       y = [y;f2];
       dti = [dti;dt];
    end
    %%%%If the loop breaks out we change the sign of dt and halve it
    dt = -0.5*dt;
    %%%Furthermore we change f1 to f2;
    f1 = f2;
end

function y = myfunc(t)

V = 10;
theta = pi/4;
vy = V*sin(theta);
a = -9.81;
y = vy*t + (1/2)*a*t^2;