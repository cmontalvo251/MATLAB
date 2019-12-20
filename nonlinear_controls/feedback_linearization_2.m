%%%Example 6.1.2
function feedback_linearization_2()
close all

%%%Third order phase portrait
f1 = figure();
ax1 = gca;
hold on
xlim([-5 5])
ylim([-5 5])
zlim([-5 5])

%%%%All three states in the time domain
f2 = figure();
ax2 = gca;
hold on
ylim([-5 5])

%%%%Y in the time domain
f3 = figure();
ax3 = gca;
hold on
ylim([-5 5])

for x1 = -5:2:5 
    x1
    for x2 = -5:2:5
        for x3 = -5:2:5
            %functionHandle,tspan,xinitial,timestep,extraparameters,next,quat
            [tout,xout] = odeK4(@Derivs,[0 10],[x1;x2;x3],0.001);
            %%%Plot a third order phase portrait
            plot3(ax1,xout(1,:),xout(2,:),xout(3,:),'b-')
            %%%Plot all three states in the time domain
            plot(ax2,tout,xout)
            %%%Plot y in the time domain
            y = xout(1,:);
            plot(ax3,tout,y)
            %drawnow
        end
    end
end



function dxdt = Derivs(t,x)

x1 = x(1);
x2 = x(2);
x3 = x(3);

%%%%Input Ouput Linearize
y = x1;
x1dot = sin(x2) + (x2+1)*x3;
ydot = x1dot;

%%%Control Gains
kp = 3;
kd = 1.5;
%%%Command Vector
yddotc = 0;
ydotc = 0;
yc = 0;
%%%%Psuedo Control
v = -yddotc-kd*(ydot-ydotc) - kp*(y-yc);

%%%Control
f = (x1^5 + x3)*(x3 + cos(x2)) + (x2+1)*x1^2;
b = x2 + 1;
u = 1/b*(v-f);

if abs(u) > 100
    u = sign(u)*100;
end

%%%Derivatives
x2dot = x1^5 + x3;
x3dot = x1^2 + u;

dxdt = [x1dot;x2dot;x3dot];