function Conical_Pit()
clear
clc
close all

%%%%%Plot the function
r = 0:0.1:10;
C = objfun(r);
plot(r,C)
hold on

ylabel('Cost ($)')
xlabel('Radius (m)')

rmin = fminbnd(@objfun,0,10)
Cmin = objfun(rmin);
plot(rmin,Cmin,'r*','MarkerSize',12)

%%%%Plot Constraint
%%% theta <= 45
%%% theta = tan^-1(h/r)
%%% tan^-1(h/r) <= 45
%%% h/r <= tan(45)
%%% h <= r*tan(45)
%%% h - r*tan(45) <= 0
%%% Limiting condition
%%% h - r*tan(45) = 0
%%% (150/(pi*r^2))- r*tan(45) = 0
%%% 150 = pi*r^3*tan(45)
%%% r^3 = 150/(tan(45)*pi)
%%% r = (150/(tan(45)*pi)^(1/3)

rmin = (150/(tan(45)*pi))^(1/3)*ones(length(C),1);
plot(rmin,linspace(0,(8e4),length(C)),'k--')

figure()
A = pi*r.^2;
h = 150./A;
theta = atan(h./r)*180/pi;
plot(r,theta)
xlabel('R (m)')
ylabel('\theta (deg)')

function C = objfun(r)
A = pi*r.^2;
h = 150./A;
SA = pi*r.*(r+sqrt(h.^2+r.^2));
C = 1500+SA*50 + A*25;

