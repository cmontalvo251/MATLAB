function parachute()

clc
k = 1;

for idx = 1:10000
    k = k - g(k)/gprime(k);
end
k

function y = g(k)
m = 82;
g = 9.81;

y = (m*g/k)*(1-exp(-4*k/m))-36;

function yprime = gprime(k)
delk = 1;
yprime = (g(k+delk)-g(k))/delk;
