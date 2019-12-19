%%%%%HOW'S DIS?
function controls_transfer_function_example()
close all

%%%%Analytic Solution
tout = 0:0.1:10;
xa = -35/53*exp(-7*tout) + 35/53*cos(2*tout) + 10/53*sin(2*tout);

%%%%%ODE45
[toutn,xoutn] = ode45(@Derivatives,[0 10],0);

%%%TRANSFER FUNCTIONS
X = zpk(0,[-2i,2i,-7],2);
impulse(X)



%%%%%PLOT ALL THE THINGS
hold on
plot(tout,xa,'r-')
plot(toutn,xoutn,'g-')
legend('Transfer Function','Analytic','ODE45')

function dxdt = Derivatives(t,x)

dxdt = -7*x + 5*cos(2*t);