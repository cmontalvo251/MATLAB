function prob20c() %%%We have to do this because we want a function within a function

clc
close all
%%%%Alright let's plot the analytic solution for 
%%%Problem 20c
tout = linspace(0,10,1000);

%%%%Solution done by hand in class on 8/27/2019
A = -2/5;
B = 4*A/3;
xout = A*exp(-4*tout).*cos(3*tout) + B*exp(-4*tout).*sin(3*tout) + 2/5;

%%%Let's plot this
plot(tout,xout,'LineWidth',2)
set(gca,'FontSize',18)
xlabel('Time (sec)')
ylabel('Position (m)')
grid on

%%%Now let's let MATLAB use ode45 
%(Ordinary Different EquatioN)
%RK4 and RK5 - Runge Kutta - 4 --> 4th order 
%%RK5 -- 5th order
%%%RK5 is better - speed. this takes longer
%%%Trade off between RK4 and RK5
% [outputs] = function(derivatives routine, time window, initica conditions)
[tout45,xout45] = ode45(@Derivatives,[0 10],[0;0]);

%%%try and plot numerical solution
hold on
%size(xout45)
plot(tout45,xout45(:,1),'r--','LineWidth',2)
legend('Analytic','Numerical')

function dstatedt = Derivatives(t,state)
x = state(1);
xdot = state(2);
xddot = 10 - 25*x - 8*xdot; %%This is the EOMs rearranged

dstatedt = [xdot;xddot];