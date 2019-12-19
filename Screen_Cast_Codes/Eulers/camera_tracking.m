clear
clc
close all

timestep = 0.001; %%%Timestep - needs to be small

a = -9.81; %%Gravity
z0 = 0; %%%Initial height of ball
V0y = 20; %%%Initial velocity of ball

%%%%Time vector
t_vec = 0:timestep:4;

%%%Height of ball
z_vec = z0 + V0y*t_vec + (1/2)*a*t_vec.^2;

%%%Plot the height of the ball
plot(t_vec,z_vec)
xlabel('Time (sec)')
ylabel('Height (m)')

%%%Our Controller and camera
J = 0.1; %%%Moment of inertia of camera
kp = 20; %%%Proportional Gain (I get to choose this)
kd = 1; %%%Derivative Gain (I get to choose this)
xs = 40; %%%Distance of ball from camera

%%%%Eulers Method
%%%Initial Conditions
theta_vec(1) = 0; %%%Initially level
thetadot_vec(1) = 0; %%%%Not moving

for n = 1:length(t_vec)-1
    theta_vec(n+1) = theta_vec(n) + thetadot_vec(n)*timestep;
    thetac_vec(n) = atan(z_vec(n)/xs);
    %thetac_vec(n) = pi/4;
    thetadbldot = -(kd/J)*thetadot_vec(n) - (kp/J)*(theta_vec(n)-thetac_vec(n));
    thetadot_vec(n+1) = thetadot_vec(n) + thetadbldot*timestep;
end

%%%Plot Angle of Camera
figure()
plot(t_vec,theta_vec*180/pi)
hold on
plot(t_vec(1:end-1),thetac_vec*180/pi,'r-')
legend('\theta of Camera','Commanded Angle')
xlabel('Time (sec)')
ylabel('Angle (degrees)')



