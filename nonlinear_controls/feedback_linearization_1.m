%%%Example 6.1.2
function feedback_linearization_1()
close all

f1 = figure();
ax1 = gca;
hold on
f2 = figure();
ax2 = gca;
hold on
for x1 = -50:5:50
    x1
    for x2 = -50:5:50
        [tout,xout] = ode45(@Derivs,[0 10],[x1;x2]);
        plot(ax1,xout(:,1),xout(:,2),'b-')
        plot(ax2,tout,xout)
        %drawnow
    end
end



function dxdt = Derivs(t,x)

x1 = x(1);
x2 = x(2);
a = 1;

%%%Transform the state
z1 = x1;
z2 = a*x2 + sin(x1);

%%%Control
k1 = 3;
k2 = 1.5;
v = -k1*z1 - k2*z2;

b = a*cos(2*z1);
f = -2*z1*cos(z1) + cos(z1)*sin(z1);
u = 1/b*(v - f); %%%Allows z2dot = v
%u = 0;

x1dot = -2*x1 + a*x2 + sin(x1);
x2dot = -x2*cos(x1) + u*cos(2*x1);

dxdt = [x1dot;x2dot];