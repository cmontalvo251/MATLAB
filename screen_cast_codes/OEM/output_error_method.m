clear
clc
close all


data = dlmread('data.txt');

time = data(:,1);
z = data(:,2);

figure()
plot(time,z)
hold on

CDguess = 0.8;

%CX, CY, and CZ

ztilde = myEuler(time,CDguess);
N = length(time);


myerr = (1/N)*sum((z-ztilde).^2);
alfa = 0.1;

while myerr > 1e-3
    CDguess = CDguess - alfa*Eprime(time,CDguess,z)/Edblprime(time,CDguess,z)
    ztilde = myEuler(time,CDguess);
    myerr = (1/N)*sum((z-ztilde).^2);
    plot(time,ztilde,'r-')
    pause
end

