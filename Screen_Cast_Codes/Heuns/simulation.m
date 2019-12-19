clear
clc
close all

timestep = 0.001;

t = 0:timestep:10;

g = 9.81;
m = 1;
L = 4;

xk = [0.1;0];

xkN = xk;

numerical = zeros(1,length(t));

for idx = 1:length(t)
    %%%Save my state
    numerical(idx) = xk(1);
    
    %%%Integrate
    xkdot = Derivs(t(idx),xk);
    xk1 = xk + xkdot*timestep;
    
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
