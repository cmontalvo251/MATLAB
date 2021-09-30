function Linear_Interpolation()
purge

x0 = 5;
f0 = myfunc(x0)
x1 = 6;
f1 = myfunc(x1)

%%%Linear Interpolation
xr = 5.5;

fr = f0 + (f1-f0)/(x1-x0)*(xr-x0)

%%%Using Gauss
Y = [f1;f0];
X = [x1-x0;x0-x0];
H = [[1;1] X];

A = inv(H'*H)*H'*Y

a0 = A(1);
a1 = A(2);

fr = a0 + a1*(xr-x0)


function out = myfunc(in)

out = 5*in + 4;
