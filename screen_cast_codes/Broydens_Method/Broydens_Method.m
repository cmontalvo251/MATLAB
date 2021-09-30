function Broydens_Method()
clc
close all

%%%Evaluate the function and see what we're working with
x1 = -2:0.1:2;
x2 = x1;
[xx2,xx1] = meshgrid(x2,x1);
zz1 = 0*xx2;
zz2 = 0*xx2;
for idx = 1:length(x1)
    for jdx = 1:length(x2)
        xij = [x1(idx);x2(jdx)];
        out = f(xij);
        zz1(idx,jdx) = out(1);
        zz2(idx,jdx) = out(2);
    end
end

figure()
mesh(xx1,xx2,zz1)
hold on
surf(xx1,xx2,zz2)

%%%%Newtons Method
%%%Solve for x such that f(x) = 0
x = [2 2]';

while err(x) > 1e-10
    %%% xnext = xnow - f(x)/fprime(x)
    %%% F is a vector function
    %%% xnext = xnow - (fprime^-1)*f(x)
    %%% Fprime is a 2x2 since f(x) is a 2x1 -- Jacobian
    s = -inv(J(x))*f(x);
    x = x + s;
end
disp('Newton Solution = ')
disp(x)

%%%Secant Method
%%%Solve for x such that f(x) = 0
x = [2 2]';

while err(x) > 1e-10
    %%% xnext = xnow - f(x)/fprime(x)
    %%% F is a vector function
    %%% xnext = xnow - (fprime^-1)*f(x)
    %%% Fprime is a 2x2 since f(x) is a 2x1 -- Jacobian
    s = -inv(Jnumerical(x))*f(x);
    x = x + s;
end
disp('Secant Solution = ')
disp(x)

%%%Broydens
%%%Solve for x such that f(x) = 0
x = [2 2]';
B = [1 0;0 1];

while err(x) > 1e-10
    %%% xnext = xnow - f(x)/fprime(x)
    %%% F is a vector function
    %%% xnext = xnow - (fprime^-1)*f(x)
    %%% Fprime is a 2x2 since f(x) is a 2x1 -- Jacobian
    s = -inv(B)*f(x);
    x1 = x + s;
    y = f(x1)-f(x);
    x = x1;
    %%%Recompute and update the approximation of B
    if abs(s'*s) > 1e-2
        B = B + ((y-B*s)*s')/(s'*s);
    end
end
disp('Broyden Solution = ')
disp(x)

disp('Jacobian, Numerical, Broyden')
disp(J(x))
disp(' ')
disp(Jnumerical(x))
disp(' ')
disp(B)



function outerr = err(x)
out = f(x);
outerr = out(1)^2+out(2)^2;

function out = f(x)
x1 = x(1);
x2 = x(2);
out = [x1+2*x2-2;x1^2+4*x2^2-4];

function out = Jnumerical(x)
%%%% f(x) = [f1; f2];

%%%% out = [df1/dx1 df1/dx2 ; df2/dx1 df2/dx2]

%%%% out = [ df/dx1 df/dx2 ] 
out = zeros(2,2);

del = 100;

%%% 1st column = df/dx1 - central differencing
dx1 = [del;0];
out(:,1) = (f(x+dx1)-f(x))/(del);

%%% 2nd colum = df/dx2
dx2 = [0;del];
out(:,2) = (f(x+dx2)-f(x))/(del);

function out = J(x)
x1 = x(1);
x2 = x(2);

out = [1 2;2*x1 8*x2];