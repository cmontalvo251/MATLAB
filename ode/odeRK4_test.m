function odeRK4_test()

[tout,xout] = odeRK4(@Derivatives,[0 10],[4;0],0.1,[],10);

plot(tout,xout)

function dxdt = Derivatives(t,x)

r = x(1);
v = x(2);

m = 1.0;
c = 5.0;
k = 10.0;

a = -c/m*v - k/m*r;

dxdt = [v;a];
