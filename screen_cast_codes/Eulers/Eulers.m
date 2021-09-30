clear
clc
close all

timestep = 0.1;

t = 0:timestep:4; %%%Create a vector from 0 to 4 in increments of timestep

c = 4;
m = 2;
V0 = 5;
ctilde = c/m;

%%%Analytical Solution
V = V0*exp(-ctilde*t);

%%%Numerical Solution
vk = V0;
vh = V0;

V_numerical = zeros(1,length(t));
V_heun = zeros(1,length(t));

for idx = 1:length(t)
    %%%Save my state
    V_numerical(idx) = vk;
    V_heun(idx) = vh;
    
    %%%%Integrate using Euler's Method
    vkdot = -ctilde*vk;
    vk1 = vk + vkdot*timestep;
    
    %%%%Integrate using Heuns Method
    vhdot = -ctilde*vh;
    vL = vh + vhdot*timestep;
    vLdot = -ctilde*vL;
    vbardot = 0.5*(vhdot + vLdot);
    vh1 = vh + vbardot*timestep;
    
    %%%Step my state
    vk = vk1;
    vh = vh1;
end

plot(t,V,'LineWidth',2)
hold on
plot(t,V_numerical,'r-','LineWidth',2)
plot(t,V_heun,'g-','LineWidth',2)
grid on

xlabel('Time')
ylabel('V')

legend('Analytical Solution','Euler''s Method','Heun''s Method(RK2)')

figure()
plot(t,V-V_numerical,'r--','LineWidth',2)
hold on
grid on
plot(t,V-V_heun,'g-','LineWidth',2)
xlabel('Time')
ylabel('Error')
legend('Euler''s Method','Heun''s Method')
