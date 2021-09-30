function unique_roots = newton_raphson_multiple_roots()

clear
clc
close all

%%%%Plot the function
%xplot = linspace(-15,30,1000);
%yplot = f(xplot);
%plot(xplot,yplot)
%hold on

xguesses = linspace(-50,50,10);
roots_NR = [];
for xinitial = xguesses
  disp(['Starting with initial guess = ',num2str(xinitial)])
  sol = NR(xinitial);
  roots_NR = [roots_NR;sol];
end

unique_roots = roots_NR(1);
for idx = 2:length(roots_NR)
   new_root = 1;
   for jdx = 1:length(unique_roots)
      if abs(unique_roots(jdx) - roots_NR(idx)) < 1e-2
        new_root = 0;
      end
   end
   if new_root
      unique_roots = [unique_roots;roots_NR(idx)];
   end
end

function sol = NR(xinitial)

iters = 1;
err = abs(f(xinitial));
xiter = xinitial; 

while (iters < 1000) && (err > 1e-4)
  %plot(xiter,f(xiter),'rx')
  xiter = xiter - f(xiter)/fprime(xiter);
  err = abs(f(xiter));
  iters = iters + 1;
end

sol = xiter;

function y = f(x)

y = (x-10).*(x+10).*(x-20); %%Three roots at 10,-10,20

function yprime = fprime(x)
%%%Secant method
dx = 0.01;

%%%Central differencing
yprime = ( f(x+dx) - f(x-dx) ) / (2*dx);