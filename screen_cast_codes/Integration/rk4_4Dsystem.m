clear
clc
close all

%%%%Temperature of an Engine in 4 different parts
timestep = 0.01;
time = 0:timestep:1000;
theta_vec = zeros(4,length(time));

%%%Set initial conditions
theta1 = 19.5; %%%Probably Celsius
theta2 = 19.5; 
theta3 = 19.5;
theta4 = 19.5;
theta_vec(:,1) = [theta1,theta2,theta3,theta4];

%%%RK4 Loop
for idx = 1:length(time)-1
   idx/length(time)*100
   k1 = Derivatives(theta_vec(:,idx));
   k2 = Derivatives(theta_vec(:,idx)+k1*timestep/2);
   k3 = Derivatives(theta_vec(:,idx)+k2*timestep/2);
   k4 = Derivatives(theta_vec(:,idx)+k3*timestep);
   kRK4 = (1/6)*(k1 + 2*k2 + 2*k3 + k4);
   theta_vec(:,idx+1) = theta_vec(:,idx) + kRK4*timestep;
end

for jdx = 1:4
figure()
plot(time,theta_vec(jdx,:))
ylabel(['Temperature \theta_',num2str(jdx),' (C)'])
xlabel('Time')
end


