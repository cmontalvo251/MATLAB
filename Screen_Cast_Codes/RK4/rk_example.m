function rk_example(D,y0,dt,nstep)
close all

%%%Eulers' method

y(1) = y0;

t = 0:dt:(dt*nstep);

a_sol = y(1)*exp(-D*t);

for n = 1:nstep
    ydot = -D*y(n);
    y(n+1) = y(n) + ydot*dt;
end

plot(y,'LineWidth',2)

yRK2(1) = 2;

for n = 1:nstep
    k1 = -D*yRK2(n);
    k2 = -D*(yRK2(n)+k1*dt);
    phi = 0.5*(k1+k2);
    yRK2(n+1) = yRK2(n) + phi*dt;
end

hold on
plot(yRK2,'r-','LineWidth',2)

yRK4(1) = 2;

for n = 1:nstep
    k1 = -D*yRK4(n);
    k2 = -D*(yRK4(n) + k1*dt/2);
    k3 = -D*(yRK4(n) + k2*dt/2);
    k4 = -D*(yRK4(n) + k3*dt);
    phi = (1/6)*(k1 + 2*k2 + 2*k3 + k4);
    yRK4(n+1) = yRK4(n) + phi*dt;
end

plot(yRK4,'g-','LineWidth',2)

plot(a_sol,'k-','LineWidth',2)

legend('RK1','RK2','RK4')

%ylim([0 2])