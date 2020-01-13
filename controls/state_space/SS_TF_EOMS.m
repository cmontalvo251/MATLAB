%%%%Analytical Solution
%%%%Need a function up top because I have a function down below
function SS_TF_EOMS()
%%%I want to close our figures so it pops up everytime
close all

%%%%LET's create the transfer function
%%%zpk stands for zero poles and gains
%%%The transfer function is X = 1/(s*(s+2)*(s+1))
%%%So the zeros are blank or []
%%%The poles are 0,-1, and -2
%%%The gain or the constant in the numerator is 1
%X = zpk([],[0,-1,-2],[1])

%%%Once we have the transfer function we simulate with impulse()
%impulse(X)

%%%We need to hold the phone so can plot multiple things on the same figure
hold on

%%%If we solve this solution by hand using partial fractions and what not.
%%%we can get analytical solution. Notice that the roots are in the
%%%solution to the analytical solution. s = 0, s = -2, s= - 1
%tout = 0:0.1:10;
%xanalytical = 0.5*exp(0*tout) + 0.5*exp(-2*tout) - exp(-tout);
%plot(tout,xanalytical,'r-')

%%%Create some initial conditions
x0 = [3;4];

%%%We can then simulate the EOMS using ode45
[t45,xvec45] = ode45(@Derivatives,[0 10],x0);
%%%Because the system is second order we need to
%%%pull out just x rather than xdot
x45 = xvec45(:,1); %%%This pulls out the first column
plot(t45,x45,'g-')

%%%%Let's simulate using State Space
[tSS,xvecSS] = ode45(@DerivativesSS,[0 10],x0);
%%%%Because the sys is 2nd order we need to pull out
%%%x
xSS = xvecSS(:,1); 
plot(tSS,xSS,'m-')

A = [0 1;-2 -3];

xvecExp = 0*xvecSS;
for idx = 1:length(tSS)
    xvecExp(idx,:) = expm(A*tSS(idx))*x0;
end

xExp = xvecExp(:,1);

plot(tSS,xExp,'g-')

%%%%This is our derivatives routine for our EOMs.
%%%Remember xvec = [x;xdot] and dxvecdt = [xdot;xdbldot]
%%%xdbldot comes from the EOMs
function dxvecdt = Derivatives(t,xvec)
x = xvec(1);
xdot = xvec(2);
xdbldot = -3*xdot - 2*x;
dxvecdt = [xdot;xdbldot];

%%%%Now let's code the SS derivatives routine
function dxvecdt = DerivativesSS(t,xvec)
A = [0 1;-2 -3];
B = [0;1];
u = 0;

dxvecdt = A*xvec + B*u;


