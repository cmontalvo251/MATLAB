function myrk4()
close all

dt = 0.4;
y0 = 2;

%%%Analytical Solution
t = 0:dt:10;
y_a_sol = y0*exp(-2*t);

figure()
plot(t,y_a_sol,'k-','LineWidth',2)
hold on

%%%EULERS METHOD

tE(1) = 0;
yE(1) = y0;
n = 1;

while tE < 10
    tE(n+1) = tE(n) + dt;
    yE(n+1) = yE(n) + f(yE(n),tE(n))*dt;
    n = n + 1;
end

plot(tE,yE,'g-','LineWidth',2)

%%% RK2 (Heun's Method)
t2(1) = 0;
y2(1) = y0;
n = 1;

while t2 < 10
    t2(n+1) = t2(n) + dt;
    k1 = f(y2(n),t2(n));
    k2 = f(y2(n)+k1*dt,t2(n)+dt);
    phi = 0.5*(k1 + k2);
    y2(n+1) = y2(n) + phi*dt;
    n = n + 1;
end

plot(t2,y2,'r-','LineWidth',2)

%%% RK4
t4(1) = 0;
y4(1) = y0;
n = 1;

while t4 < 10
    t4(n+1) = t4(n) + dt;
    k1 = f(y4(n),t4(n));
    k2 = f(y4(n)+k1*dt/2,t4(n)+dt/2);
    k3 = f(y4(n)+k2*dt/2,t4(n)+dt/2);
    k4 = f(y4(n)+k3*dt,t4(n)+dt);
    phi = (1/6)*(k1 + 2*k2 + 2*k3 + k4);
    y4(n+1) = y4(n) + phi*dt;
    n = n + 1;
end

plot(t4,y4,'b-','LineWidth',2)

legend('Analytical Solution','Eulers','RK2(Huens)','RK4')



function ydot = f(y,t)
%%% ydot + 2y = 0

ydot = -5*y;
