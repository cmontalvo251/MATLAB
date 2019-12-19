clear
clc
close all

global F

ANIMATION = 1;

%%%Time vector
dt = 0.01;
time = 0:dt:200;

fig = figure;

color = {'b-','r-','g-','m-','c-'};
ctr = 0;

%%%Initial Conditions
xstate = zeros(5,length(time));
Fstate = zeros(1,length(time));

x0 = [45*pi/180 0 0 0 0]';

xstate(:,1) = x0;
Fstate(1) = 0;
for k = 1:length(time)-1
    %%%Runge_Kutta
    xk = xstate(:,k);
    tk = time(k);
    k1 = Derivatives(xk,tk);
    k2 = Derivatives(xk+k1*dt/2,tk+dt/2);
    k3 = Derivatives(xk+k2*dt/2,tk+dt/2);
    k4 = Derivatives(xk+k3*dt,tk+dt);
    phi = (1/6)*(k1 + 2*k2 + 2*k3 + k4);
    xstate(:,k+1) = xstate(:,k) + phi*dt;
    Fstate(k+1) = F;
    theta = xstate(1,k+1);
    L = 2;
    if ANIMATION
        cla;
        xc = 0;
        yc = xstate(3,k+1);
        x = xc + L*cos(theta);
        y = yc + L*sin(theta);
        plot(y,x,'rs','MarkerSize',10)
        hold on
        plot([y yc],[x 0],'g-','LineWidth',2)
        CubeDraw(2,1,1,yc,0,0,0,0,0,[1 0 0])
        circle(yc-0.9,xc-0.7,0.2,'b')
        circle(yc+0.9,xc-0.7,0.2,'b')
        axis([-L+yc L+yc -L L])
        drawnow
    end
end

figure()
theta = xstate(1,:);
plot(time,theta*180/pi)
hold on

ylabel('Theta (deg)')
xlabel('Time (sec)')

figure()
plot(time,Fstate)
xlabel('Time (sec)')
ylabel('Force (N)')
