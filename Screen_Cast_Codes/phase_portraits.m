function phase_portraits()
close all
clc

tspan = [0 10];
figure()
hold on
for x0 = (-2*pi):0.5:(2*pi)
    for xdot0 = -3:0.2:3
        xinitial = [x0;xdot0];
        [tout,stateout] = ode45(@Derivatives,tspan,xinitial);
        %%%Phase Plane
        xout = stateout(:,1);
        xdotout = stateout(:,2);
        plot(xout,xdotout)
        drawnow
        axis([-10 10 -10 10])
    end
end

function dstatedt = Derivatives(t,state)

%x = state(1);
%xdot = state(2);

%%% s^2 + 2*zeta*wn*s + wn^2
%k = 10;
%m = 1;
%wn = sqrt(k/m);
%zed = 5;
%c = 2*zed*wn;
%A = [0 1;-k/m -c/m];
%xdbldot = -k/m*x - c/m*xdot;


theta = state(1);
thetadot = state(2);

g = 16;
L = 1;
c = 0;
%thetadbldot = -g/L*sin(theta) - c*thetadot;

%%% dxdot = df/dx * dx
%%% dx = x - x0
theta0 = pi;
A = [0 1;-g/L*cos(theta0) -c];

dstatedt = A*state;

%dstatedt = [thetadot;thetadbldot];
