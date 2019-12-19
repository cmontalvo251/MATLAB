clear
clc
close all

timestep = 0.001;

t = 0:timestep:10;

g = 9.81;
m = 1;
L = 4;

xk = [pi/2;0];

numerical = zeros(1,length(t));

for idx = 1:length(t)
    %%%Save my state
    numerical(idx) = xk(1);
    
    %%%Integrate (RK4)
    tk = t(idx);
    k1 = Derivs(tk,xk);
    k2 = Derivs(tk+timestep/2,xk+k1*timestep/2);
    k3 = Derivs(tk+timestep/2,xk+k2*timestep/2);
    k4 = Derivs(tk+timestep,xk+k3*timestep);
    phi = (1/6)*(k1 + 2*k2 + 2*k3 + k4);
    xk1 = xk + phi*timestep;
    
    %%%Step my state
    xk = xk1;    
end

fig = figure();
set(fig,'color','white');
set(axes,'FontSize',18)
plot(t,numerical,'b-','LineWidth',2)
hold on
xlabel('Time(sec)')
ylabel('Output')
grid on
