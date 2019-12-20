function duffing()
global alfa bata c
clc
close all

bata = 1;
alfa = linspace(-2,2,10);
c = 2;

xdot_eq = 0;

for idx = 1:length(alfa)
    alfa_i = alfa(idx)
    coeff = [bata 0 alfa(idx) 0];
    eq_pts = roots(coeff);
    eq_pts = real(eq_pts);
    eq_pts = unique(eq_pts);
    for jdx = 1:length(eq_pts)
        x_eq = eq_pts(jdx)
        A = [0 1;-alfa(idx)-3*bata*x_eq^2 -c]
        eigenvalues = eig(A)
    end
    pause
    clc
end




function dxdt = Nonlin(t,xvec)
global alfa bata c

x = xvec(1);
xdot = xvec(2);
xdbldot = -c*xdot - alfa*x - bata*x^3;

dxdt = [xdot;xdbldot];

