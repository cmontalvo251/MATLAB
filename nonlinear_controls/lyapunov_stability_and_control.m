function lyapunov_stability_and_control()
close all

global g L m k b

g = 9.81;
L = 2;
m = 1;
k = 10;
b = 2;

x = linspace(-10,10,100);
xdot = linspace(-10,10,100);
[xx,xxdot] = meshgrid(x,xdot);

%%%Mass Spring Damper System
%%%Function must be positive everywhere except the equilibrium point
%%%At the equilibrium point it must be zero
%V = (k/m)*0.5*(xx).^2 + 0.5*xxdot.^2;
%xxddot = -k/m*xx - b/m*xxdot;
%%%If Vdot is less than or equal to zero everywhere then the system
%%%is stable at the equilibrium point. Note that Vdot must be zero
%%%at the equilibrium point
%Vdot = (k/m)*xx.*xxdot + xxdot.*xxddot;

%%%Stable Pendulum
%V = g/(2*L)*0.5*(xx).^2 + 0.5*xxdot.^2;
%Vdot = -(b)*xxdot.^2;

%%%Nonlinear Stable Pendulum
%V = g/(2*L)*0.5*(xx).^2 + 0.5*xxdot.^2;
%Vdot = g/L*(xx.*xxdot-sin(xx).*xxdot)-(b)*xxdot.^2;

%%%Inverted Pendulum
%V = g/(2*L)*0.5*(xx).^2 + 0.5*xxdot.^2;
%Vdot = 2*g/L*xx.*xxdot-(b)*xxdot.^2;

%%%Nonlinear Unstable Pendulum
V = g/(2*L)*(xx).^2 + 0.5*xxdot.^2;
uu = m*L^2*(-g/L*(xx + sin(xx)));
xxddot = g/L*sin(xx) - b*xxdot + uu/(m*L^2);
Vdot = (g/L)*xx.*xxdot + xxdot.*xxddot;

%%%Make V and Vdot
figure()
mesh(xx,xxdot,V)
%[tout,xout] = ode45(@Derivs,[0 100],[0;2]);
%x = xout(:,1);
%xdot = xout(:,2);
%Vi = (k/m)*0.5*(x).^2 + 0.5*xdot.^2;
%Vi = g/(2*L)*0.5*(x).^2 + 0.5*xdot.^2;
%Vdot(0) = 0
%xddot(0) = k/m*10
%xdot(0) = 0
%x(0) = -10
%hold on
%plot3(x,xdot,Vi)
%figure()
%plot(tout,Vi)
figure()
mesh(xx,xxdot,Vdot)
figure()
Vdot(Vdot < 0) = -1;
Vdot(Vdot > 0) = 1;
mesh(xx,xxdot,Vdot)

%%%Phase Portrait
figure()
for x = -10:1:10
    for xdot = -10:1:10
        [tout,xout] = ode45(@Derivs,[0 100],[x;xdot]);
        hold on
        plot(xout(:,1),xout(:,2))
    end
end
xlim([-10 10])
ylim([-10 10])

function dxdt = Derivs(t,xvec)
global k b m g L

x = xvec(1);
xdot = xvec(2);
%%%Mass spring damper
%xdbldot = -b/m*xdot - k/m*x;
%%%Inverted Pendulum
%gam = -2*g/L*x;
%u = m*L^2*gam;
%xdbldot = g/L*x - b*xdot;% + u/(m*L^2);

%%%%Stable Pendulum
%xdbldot = -g/L*x - b*xdot;

%%%Stable Nonlinear Pendulum
%xdbldot = -g/L*sin(x) - b*xdot;

%%%Unstable Nonlinear Pendulum
u = m*L^2*(-g/L*(x + sin(x)));
xdbldot = g/L*sin(x) - b*xdot + u/(m*L^2);

dxdt = [xdot;xdbldot];