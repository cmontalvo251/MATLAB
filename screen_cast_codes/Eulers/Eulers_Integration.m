function Eulers_Integration()

close all
clc
%clear

timestep = 0.1;

t = 0:timestep:1;


V0 = 5;
c = 4;
m = 2;
ctilde = c/m;


%%%Analytical Solution
V = V0*exp(-ctilde*t);

%%%Numerical Solution
vi = V0;
V_n = zeros(1,length(t));
for idx = 1:length(t)
    
    %%%%Save my state
    V_n(idx) = vi;
    
    %%%Euler's Integration
    vidot = -ctilde*vi;
    vi1 = vi + vidot*timestep;
    
    %%%Step our state
    vi = vi1;
end

%%%%Plot it
plot(t,V,'LineWidth',2)
hold on
plot(t,V_n,'r--','LineWidth',2)

xlabel('Time')
ylabel('Velocity')

grid on

legend('Analytical Solution','Numerical Solution')

figure()

plot(t,V-V_n)
