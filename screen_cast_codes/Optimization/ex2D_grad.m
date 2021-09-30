function ex2D_grad()


close all
clear
clc


rho = linspace(-100,100,200);
T = linspace(-200,200,200);

[rhog,Tg] = meshgrid(rho,T);

pg = myfunc(rhog,Tg);

mesh(rhog,Tg,pg)
hold on

%%%%Initial Condition
rho0 = 1;
T0 = 200;
x0 = [rho0;T0];
%%%Choose Alfa
alfa = 0.2;

for idx = 1:1000
    p0 = myfunc(x0(1),x0(2));
    plot3(x0(1),x0(2),p0,'ks','MarkerSize',20)
    x1 = x0 - alfa*grad(x0(1),x0(2))
    p1 = myfunc(x1(1),x1(2));
    plot3([x0(1) x1(1)],[x0(2) x1(2)],[p0 p1],'r-')
    x0 = x1;
end

function delp = grad(rho,T)

delp = [-8+2*rho-2*T;12+8*T-2*rho];

function p = myfunc(rho,T)

p = -8*rho + rho.^2 + 12*T + 4*T.^2 - 2*rho.*T;

