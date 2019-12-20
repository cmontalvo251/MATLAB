function duffing_phase()
global alfa bata c x_eq
clc
close all

bata = 1;
a = linspace(-2,2,1);
c = 2;

%%%%alfa > 0, 1 eq , 1 stable
%%%%alfa < 0, 3 eq , 2 stable 1 unstable

x = linspace(-0.1,0.1,2);
xdot = linspace(-0.1,0.1,2);
figure()
hold on
for alfa = a
    alfa
    coeff = [bata 0 alfa 0];
    eq_pts = roots(coeff);
    eq_pts = real(eq_pts);
    eq_pts = unique(eq_pts);
    x_eq = eq_pts(1);
    for idx = 1:length(x)
        for jdx = 1:length(xdot)
            xinitial = [x(idx);xdot(jdx)];
            [tout,xout] = ode45(@Nonlin,[0 20],xinitial);
            alfa_vec = alfa*ones(length(tout),1);
            plot3(xout(:,1),xout(:,2),alfa_vec,'b-')
            plot3(xout(1,1),xout(1,2),alfa_vec,'g*')
            plot3(xout(end,1),xout(end,2),alfa_vec,'rs')
            
            [toutL,xoutL] = ode45(@Lin,[0 20],xinitial);
            alfa_vec = alfa*ones(length(toutL),1);
            plot3(xoutL(:,1),xoutL(:,2),alfa_vec,'r-')
            plot3(xoutL(1,1),xoutL(1,2),alfa_vec,'g*')
            plot3(xoutL(end,1),xoutL(end,2),alfa_vec,'m^')
        end
    end
end

function dxdt = Nonlin(t,xvec)
global alfa bata c

x = xvec(1);
xdot = xvec(2);
xdbldot = -c*xdot - alfa*x - bata*x^3;

dxdt = [xdot;xdbldot];

function dxdt = Lin(t,xvec)
global alfa bata c x_eq

A = [0 1;-alfa-3*bata*x_eq^2 -c];

dxdt = A*xvec;