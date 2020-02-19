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
V = (k/m)*0.5*(xx).^2 + 0.5*xxdot.^2;
Vdot = -(b/m)*xxdot.^2;

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
%V = g/(2*L)*0.5*(xx).^2 + 0.5*xxdot.^2;
%Vdot = g/L*(xx.*xxdot+sin(xx).*xxdot)-(b)*xxdot.^2;


%%%Make V and Vdot
figure()
mesh(xx,xxdot,V)
figure()
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
xdbldot = -b/m*xdot - k/m*x;
%%%Inverted Pendulum
%gam = -2*g/L*x;
%u = m*L^2*gam;
%xdbldot = g/L*x - b*xdot + u/(m*L^2);

%%%%Stable Pendulum
%xdbldot = -g/L*x - b*xdot;

%%%Stable Nonlinear Pendulum
%xdbldot = -g/L*sin(x) - b*xdot;

%%%Unstable Nonlinear Pendulum
%u = m*L^2*(-g/L*(x + sin(x)));
%xdbldot = g/L*sin(x) - b*xdot + u/(m*L^2);

dxdt = [xdot;xdbldot];