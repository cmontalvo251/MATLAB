%%%IS THIS BIG ENOUGH????

function Parameter_Estimation()
global sig a 


clc
close all

%%%%Define our parameters
a = 2;
asymp = 3;
sig = asymp*a;

%%%IMPULSE WAY
%%%zpk stands for zeroes poles and gain
%%%why is gain k? => because gain in a control block diagram is k
%%%what are zeroes => roots for s of the numerator
%%%what are poles => roots of the characteristic equation or the denominator
X = zpk([],[0,-a],[sig]);
%%%Simulate the transfer function
impulse(X)

%%%%Analytic Solution
ta = 0:0.01:10;
xa = sig/a * ( 1 - exp(-a*ta));

hold on
plot(ta,xa,'r-')

%%%%Third Way
[tout,xout] = ode45(@Derivatives,[ta(1) ta(end)],0);

plot(tout,xout,'g-')


%%%%MY DATA
tdata = [0 0.5 1.0 1.5 2.0 2.5 3.0 3.5 4.0];
xdata = [0 2 2.5 2.7 2.9 3.1 3.2 3.0 3.0];

plot(tdata,xdata,'b*')
xlim([tdata(1) tdata(end)])


legend('Laplace','Analytic','Ode45','MyData')

function dxdt = Derivatives(t,x)
global sig a

dxdt = -a*x + sig;




