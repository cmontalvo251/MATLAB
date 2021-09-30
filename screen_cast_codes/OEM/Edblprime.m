function out = Edblprime(time,CDguess,z)

%%%Forward Differencing
N = length(z);

delCD = 0.01;

ztilde2 = myEuler(time,CDguess+2*delCD);

myerr2 = (1/N)*sum((z-ztilde2).^2);

ztilde1 = myEuler(time,CDguess+delCD);

myerr1 = (1/N)*sum((z-ztilde1).^2);

ztilde0 = myEuler(time,CDguess);

myerr0 = (1/N)*sum((z-ztilde0).^2);

%out = (E(x+2*delx) - 2*E(x+delx) + E(x))/delx^2

out = (myerr2 - 2*myerr1 + myerr0)/(delCD^2);
