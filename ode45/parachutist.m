function parachutist()
global m c g

%%%Parameters
m = 100;
c = 50;
g = 9.81;

%%%%%NUMERICAL INTEGRATION

%%%%Specify length of time to simulate
tspan = [0 20];
%%%Initial conditions
vinitial = 0;

%%%Ode45 built in function call
%%%If you are using octave send me
%%%an email
[tout,vout] = ode45(@Derivs,tspan,vinitial);

%%%Plot the output
close all
figure()
plot(tout,vout)
xlabel('Time (sec)')
ylabel('Velocity (m/s)')

%%%%%ANALYTICAL SOLTUTION
A = -19.62;
B = 19.62;
vanalytical = A*exp(-50/100*tout) + B;

hold on
plot(tout,vanalytical,'r--')

%%%%Derivative function call
function vdot = Derivs(t,v)
global c m g

vdot = -c/m*v + g;

