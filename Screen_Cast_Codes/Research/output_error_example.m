%%%%Generate Seed Data
function output_error_example()

clc
close all

global CD xout tspan xinitial timestep

CD = 0.3;

tspan = [0 10];

timestep = 0.1;

x0 = 100;
v0 = 0;

xinitial = [x0;v0];

[tout,xout] = odeK4(@Derivs,tspan,xinitial,timestep,CD,'off');

figure()
plot(tout,xout,'b-')
xlabel('Time(sec')
ylabel('X(m) and V(m/s)')
grid on
hold on

%%%How do I estimate CD?
%%% Let's say I start with a guess

CD = 0.1
E0 = E(CD)

%%%The goal is to get the error down to zero right? So right now I have 
%%% E = f(CD) I want to find the minimum of f(CD). How do I do that? The
%%% newton raphson method.

iter = 0;
itermax = 100;

while E0 > 1e-2 && iter < itermax
     
    CD = CD - fprime(CD)/fdblprime(CD)
    E0 = E(CD)
    iter = iter + 1
     
end

[tguess,xguess] = odeK4(@Derivs,tspan,xinitial,timestep,CD,'off');
plot(tout,xguess,'r--')


%%%Can't get any closer why not?
% figure()
% hold on
% for CD = 0.29:0.0001:0.31
%    plot(CD,E(CD),'b*')
%    drawnow
% end
    

function out = fdblprime(CD)

del = 1e-4;

out = (E(CD+2*del) - 2*E(CD+del) + E(CD))/(del^2);

function out = fprime(CD)

del = 1e-4;

out = (E(CD+del) - E(CD))/del;


function out = E(CD)
global xout tspan xinitial timestep

[tguess,xguess] = odeK4(@Derivs,tspan,xinitial,timestep,CD,'off');
out = sum(sum((xguess-xout).^2));

