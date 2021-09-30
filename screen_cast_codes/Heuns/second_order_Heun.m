clear
clc
close all

timestep = 0.1;

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

xkH = xk;

y_numerical = zeros(1,length(t));
y_numerical_Heun = y_numerical;

ydd = -g;

for idx = 1:length(t)
    
    %%%%Save my state
    y_numerical(idx) = xk(1);
    y_numerical_Heun(idx) = xkH(1);
            
    %%%%Integrate my state
    %yk1 = yk+ykdot*timestep;
    %yk1dot = ykdot + ydd*timestep;
    xkdot = [xk(2);-g];
    xk1 = xk + xkdot*timestep;
    
    k1 = [xkH(2);-g];
    xL = xkH + k1*timestep;
    k2 = [xL(2);-g];
    phi = 0.5*(k1 + k2);
    xk1H = xkH + timestep*phi;
        
    %%%%Step my state
    %yk = yk1;
    %ykdot = yk1dot;
    xk = xk1;
    
    xkH = xk1H;
    
end

figure()
plot(t,y_analytical)
hold on
plot(t,y_numerical,'r--')
plot(t,y_numerical_Heun,'g--')
xlabel('Time')
ylabel('Y')

