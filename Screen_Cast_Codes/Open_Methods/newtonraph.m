function x0 = newtonraph()

clear
clc

k0 = 1;
iter = 0;

while abs(f(k0)) > 1e-3;

    iter = iter + 1;
    k1 = k0 - f(k0)/fprime(k0);
    k0 = k1

end


function out = f(k)

m = 82;
g = 9.8;
out = (m*g/k)*(1 - exp(-4*k/m)) - 36;

function out = fprime(k)
delk = 0.1;
out = (f(k+delk)-f(k))/delk;

