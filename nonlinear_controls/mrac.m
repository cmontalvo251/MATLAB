%%%%%
function mrac()
global CONTROLTYPE m xdotcommand kp kd lambda lambda1 lambda2 g

clc
close all

%%%Open Loop
CONTROLTYPE = 4; %%%0 = No control, 1 = constant, 2 = PD Control, 3 = fdb lin

xinitial = [0.5;0];
m = 2;
xdotcommand = 0;
kp = -5000;
kd = -300;
lambda = 6;
lambda1 = 10;
lambda2 = 25; %%%natural frequency
mhat0 = 0;
g = 0.5;

tspan = [0 30];
timestep = 0.01;
[tout,xout,Extraout] = odeK4(@Derivs,tspan,[xinitial;xinitial;mhat0],timestep,[42;0]);

plottool(1,'States',18,'Time (sec)','States');
plot(tout,xout(1,:))
plot(tout,xout(3,:),'r-')
%plot(tout,Extraout(2,:),'b--')
%legend('X','Xm','Xcommand')
legend('X','Xm')

plottool(1,'States',18,'Time (sec)','Mass')
plot(tout,xout(5,:))


%plottool(1,'States',18,'Time (sec)','Extra States');
%plot(tout,Extraout(1,:))

function [dxdt,outs] = Derivs(t,xvec,y)
global CONTROLTYPE m xdotcommand kp kd lambda lambda1 lambda2 g 

x = xvec(1);
xdot = xvec(2);
xm = xvec(3);
xdotm = xvec(4);
mhat = xvec(5);

xc = sin(4*t);

%%%Simulate the model
rc = xc;
xddotm = lambda2*rc - 2*lambda1*xdotm - lambda2*xm;

switch CONTROLTYPE
    case 0
        u = 0;
    case 1
        u = 50;
    case 2 
        u = kp*(x-xc) + kd*(xdot-xdotcommand);
    case 3
        xtilde = x - xm;
        xtildedot = xdot - xdotm;
        v = xddotm - 2*lambda*xtildedot - lambda^2*xtilde;
        u = v*m;
    case 4
        xtilde = x - xm;
        xtildedot = xdot - xdotm;
        v = xddotm - 2*lambda*xtildedot - lambda^2*xtilde;
        u = v*mhat;
end

%%%Simulate the actual system
xddot = u/m;

%%%Simulate the Adaptive Parameter Dynamics
s = xtildedot + lambda*xtilde;
mhatdot = -g*v*s;

dxdt = [xdot;xddot;xdotm;xddotm;mhatdot];

outs = [u;xc];