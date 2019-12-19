function out = Eprime(time,CDguess,z)

%%%Forward Differencing
N = length(z);

delCD = 0.01;

ztilde2 = myEuler(time,CDguess+delCD);

myerr2 = (1/N)*sum((z-ztilde2).^2);

ztilde1 = myEuler(time,CDguess);

myerr1 = (1/N)*sum((z-ztilde1).^2);

%out = (E(x+delx) - E(x))/delx

out = (myerr2 - myerr1)/delCD;
