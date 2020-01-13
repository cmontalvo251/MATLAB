function spacecraft()
global T

clc 
close all

%%%%Simulate System
[tout,xout] = ode45(@Derivatives,[0 200],[-50;0]);

%%%Make T a global and run through calculations
%%%so we can plot Thrust
T_vec = 0*tout;
for idx = 1:length(tout)
    dxdt  = Derivatives(tout(idx),xout(idx,:));
    T_vec(idx) = T;
end

%%%plot position
plot(tout,xout(:,1))
xlabel('Time (sec)')
ylabel('Position (m)')

%%%plot velocity
figure()
plot(tout,xout(:,2))
xlabel('Time (sec)')
ylabel('Velocity (m/s)')

%%%plot thrust
figure()
plot(tout,T_vec)
xlabel('Time (sec)')
ylabel('Thrust (N)')

function dxdt = Derivatives(t,xvec)
global T

%%%Extract state vector
x = xvec(1);
xdot = xvec(2);

%%%Givens
m = 500;

%%%Control Req's
Ts = 100; %%%You can play with this if you'd like to see how the system changes
wn = 4/Ts; %%This assume zeta = 1 or that OS = 0

%%%compute kp and kd based on OS and Ts req's
%%%we computed these by hand
kd = 2*m*wn; 
kp = m/4 * (kd/m)^2;

%%%Feedback control
T = -kp*x - kd*xdot;

%%%EOMs
xdbldot = T/m;

%%%Put back into matrix form. Might make more sense
%%%to use SS but whatever
dxdt = [xdot;xdbldot];