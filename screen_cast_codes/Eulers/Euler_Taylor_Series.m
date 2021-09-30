clear
clc
close all

timestep = 0.001;

t = 0:timestep:2;

m = 1;
v0 = 8;
y0 = 4;
g = 9.81;

y_analytical = y0 + v0*t - (1/2)*g*t.^2;
v_analytical = v0 - g*t;

yk = y0;
ykdot = v0;
xk = [yk;ykdot];

y_numerical = zeros(1,length(t));
ydot_numerical = zeros(1,length(t));

ydd = -g;

for idx = 1:length(t)
    
    %%%%Save my state
    y_numerical(idx) = xk(1);
    %ydot_numerical(idx) = ykdot;
            
    %%%%Step your state
    xkdot = [xk(2);ydd];
    xkddot = [ydd;0];
    xk1 = xk + xkdot*timestep + xkddot*(timestep^2)/2;
    %yk1 = yk+ykdot*timestep;
    %yk1dot = ykdot + ydd*timestep;
    
    %%%%Step my state
    xk = xk1;
    %yk = yk1;
    %ykdot = yk1dot;
    
end

figure()
plot(t,y_analytical)
hold on
plot(t,y_numerical,'r--')
xlabel('Time')
ylabel('Y')

figure()
error_in = 100*(y_analytical-y_numerical)./y_analytical;
plot(t,error_in)
