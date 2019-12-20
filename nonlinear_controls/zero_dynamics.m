function zero_dynamics()
close all
figure()
ax_phase = gca;
hold on
figure()
ax_time = gca;
hold on
for x1 = -5:1:5
    for x2 = -5:1:5
        [tout,xout] = ode45(@Derivs,[0 10],[x1;x2]);
        plot(ax_phase,xout(:,1),xout(:,2))
        plot(ax_time,tout,xout(:,1),'b-')
        plot(ax_time,tout,xout(:,2),'r-')
        drawnow
    end
end

function dxdt = Derivs(t,xvec)

x1 = xvec(1);
x2 = xvec(2);

%%%Feedback Lin
g = 1;
f = x2;
yc = 0;
y = x1;
ydotc = 0;
kp = 2;
v = ydotc + kp*(yc-y);
u = 1/g*(v-f);

%%%
kp = 30;
g = -x1*x2 + x2 - kp;
u = g/(x1-x2-1);
s = 10;
if abs(u) > s
    u = s*sign(u);
end

dxdt = [x2 + u;-u];
