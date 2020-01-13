%##Main script
close all
clc
clear

%#integrate for 10 seconds
tout = linspace(0,10,10000);

%###Zeros poles and gains
%# X = 15 / ((s^2+9) * (s^2 + 6s + 8) )
sys = zpk([],[-2,-4,-3j,3j],15)
impulse(sys,tout)
hold on

%##Analytic Solution using Inverse Laplace
A = 15.0/26.0;
B = -15.0/50.0;
D = (15-36*A-18*B)/8.0;
C = (15-50*A-30*B-15*D)/15.0;
x_analytic_laplace = A*exp(-2*tout) + B*exp(-4*tout) + C*cos(3*tout) + D/3.0*sin(3*tout);
plot(tout,x_analytic_laplace,'k--','LineWidth',10)

grid on
legend('Laplace','Analytical')
