function x0 = newton_raphson()
clear
clc

x0 = 10;

iter = 0;

alfa = 1.0;

while abs(f(x0)) > 1e-5
    
    iter = iter + 1;

    %%%Finds the zero
    %x1 = x0 - alfa*f(x0)/fprime(x0)
    %%%Finds the minimum
    x1 = x0 - alfa*fprime(x0)/fdblprime(x0)
    
    x0 = x1;

end

function out = f(in)

out = in^3 - 1; %%%x = 1 leads to y = 0

function out = fprime(in)

out = 3*in^2;

function out = fdblprime(in)

out = 6*in;