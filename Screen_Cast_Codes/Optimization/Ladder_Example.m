function Ladder_Example()
close all
clc

m = -10:0.1:(-0.1);
L2 = f(m);

plot(m,L2)

m0 = -1;
alfa = 0.1;

for idx = 1:1000
    m0 = m0 - alfa*fprime(m0)/fdblprime(m0)
end
hold on
plot(m0,f(m0),'b*','MarkerSize',20)

mfminbdn = fminbnd(@f,-10,-0.1)
mfminsearch = fminsearch(@f,-1)

function L2 = f(m)

L2 = (((4-4*m).^2)./(m.^2)).*(m.^2+1);

function out = fprime(m)
delm = 0.001;
out = (f(m+delm)-f(m))/delm;

function out = fdblprime(m)
delm = 0.001;
out = (f(m+2*delm)-2*f(m+delm)+f(m))/(delm^2);
