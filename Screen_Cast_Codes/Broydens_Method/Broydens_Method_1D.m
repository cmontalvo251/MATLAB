function Broydens_Method_1D()
clc
close all

%%%Klaus Antonio
%%%Hello Monte! I'm trying to adapt your code to a 
%single equation solution, but I didn't succeeded 
%until now. May you help me about it? What I need 
%to do to solve only f(x) = x(1)^2 + 10*x(2)^2 instead
%of those two equations on your example? Thanks
%!Klaus Antonio

%%%Evaluate the function and see what we're working with
x1 = -2:0.1:2;
x2 = -2:0.1:2;
[xx1,xx2] = meshgrid(x1,x2);
zz = 0*xx1;
for idx = 1:length(x1)
    for jdx = 1:length(x2)
        xij = [x1(idx);x2(jdx)];
        zz(idx,jdx) = f(xij);
    end
end

figure()
mesh(xx1,xx2,zz)

%%%%Newtons Method
%%%Solve for x such that f(x) = 0
x = [2 2]';
alfa = 0.01;
numiters = 0;
tic
while err(x) > 1e-10
    numiters = numiters +1;
    %%% This is for 1D
    %%% xnext = xnow - f(x)/fprime(x)
    %%% F is a vector function
    %%% xnext = xnow - (fprime^-1)*f(x)
    %%% x is 2x1, f is a 1x1 x = [x1;x2]
    %%% fprime = [df/dx1;df;dx2];
    %x
    %f(x)
    %fprime(x)
    s = -alfa*f(x)./fprime(x);
    x = x + s;
end
disp('Newton Solution = ')
disp(x)
disp(f(x))
disp(err(x))
disp(numiters)
toc

%%%Secant Method
%%%Solve for x such that f(x) = 0
tic
x = [2 2]';
numiters = 0;
while err(x) > 1e-10
    numiters = numiters + 1;
    %%% xnext = xnow - f(x)/fprime(x)
    %%% F is a vector function
    %%% xnext = xnow - (fprime^-1)*f(x)
    %%% Fprime is a 2x2 since f(x) is a 2x1 -- Jacobian
    s = -alfa*f(x)./fsecant(x);
    x = x + s;
end
disp('Secant Solution = ')
disp(x)
disp(f(x))
disp(err(x))
disp(numiters)
toc

%%%Broydens
%%%Solve for x such that f(x) = 0
tic
x = [2 2]';
B = fsecant(x)';
alfa = .001;
numiters = 0;
while err(x) > 0.01
    numiters = numiters + 1;
    %%% xnext = xnow - f(x)/fprime(x)
    %%% F is a vector function
    %%% xnext = xnow - (fprime^-1)*f(x)
    %%% Fprime is a 2x2 since f(x) is a 2x1 -- Jacobian
    s = -alfa*f(x)./B'; %% s is a 2x1 B is also a 2x1
    x1 = x + s; %%% x1 is 2x1 = x is 2x1 s is a 2x1
    y = f(x1)-f(x); %%y is a 1x1
    x = x1; %%% 2x1
    %%%Recompute and update the approximation of B
    if abs(s'*s) > 1e-2  %% s' 1x2 * 2x1 = 1x1
        B = B + ((y-B*s)*s')/(s'*s); 
    end
end
disp('Broyden Solution = ')
disp(x)
disp(err(x))
disp(numiters)
toc

disp('Jacobian, Numerical, Broyden')
disp(fprime(x))
disp(' ')
disp(fsecant(x))
disp(' ')
disp(B')

function outerr = err(x)
outerr = f(x)^2;

function out = f(x)
out = x(1)^2 + 10*x(2)^2;

function out = fprime(x)
x1 = x(1);
x2 = x(2);
%%% df/dx1 df/dx2
out = [2*x1;20*x2];

function out = fsecant(x)
x1 = x(1);
x2 = x(2);
out = [0;0];
dx = 1e-6;
out(1) = (f([x1+dx;x2]) - f([x1-dx;x2]))/(2*dx);
out(2) = (f([x1;x2+dx]) - f([x1;x2-dx]))/(2*dx);