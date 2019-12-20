%%%%%Geared Vehicle Code
function geared_vehicle()

clc
close all

tspan = [0 100];
xinitial = [(1/12)/3.28;0];
[tout,xout] = ode45(@Derivs,tspan,xinitial);

figure()
plot(tout,xout(:,1))
ylabel('Position')

figure()
plot(tout,xout(:,2))
ylabel('Velocity')


function dxdt = Derivs(t,xvec)

%%%States
x = xvec(1);
xdot = xvec(2);

%%%Constants
gravity = 9.81;
mass_rider = 185/2.2; %%kilos
mass_vehicle = 20/2.2; %%kilos
radius_tire = ((24/12)/3.28)/2; %%%meters
radius_rear = ((2/12)/3.28)/2; %%%we can change this
radius_front = ((8/12)/3.28)/2; %%%Assume is a constant
Lp = ((10/12)/3.28)/2; %%%length of pedals
theta_rads_max = 60*2*pi/60; %%%rad/s
n = 2.5;

%%%Kinematics 
%%velocity = omega * r
theta_tire_dot = xdot/radius_tire;
theta_rear_dot = theta_tire_dot;
theta_front_dot = (radius_rear/radius_front)*theta_rear_dot;
%% distance traveled = r * theta
theta_tire = x/radius_tire;
theta_rear = theta_tire;
theta_front = (radius_rear/radius_front)*theta_rear;

%%%Force Commanded by brain
fr = 10000; %%%Obviously wishful thinking

%%%%%Force applied to leg? - Limited by leg muscles
if fr > n*mass_rider*gravity
    frbar = n*mass_rider*gravity;
else
    frbar = fr;
end

%%%Force applied to pedal - limited by RPM
FRbar = frbar*(1-theta_front_dot/theta_rads_max);
if theta_front_dot > theta_rads_max
    FRbar = 0;
end

%%%Torque applied to crank shaft
torque_crank_shaft = FRbar*Lp*abs(sin(theta_front));

%%%Torque From Crank Shaft
torque_tire = (radius_rear/radius_front)*torque_crank_shaft;

%%%Force
force_tire = torque_tire/radius_tire;
c = 0.75; %%%Average Streamline drag that K-Nels found on the Interwebs
drag = c*xdot;
FN = (mass_rider + mass_vehicle)*gravity;
mu = 0.004; %%%Mr. Google at his finest
friction = mu*FN;

%%%Dynamics
xdbldot = (1/(mass_rider+mass_vehicle))*(-drag + force_tire);

if xdbldot > 0
    xdbldot = xdbldot - friction/(mass_rider + mass_vehicle);
end
if xdot < 0
    xdbldot = 0;
    xdot = 0;
end

dxdt = [xdot;xdbldot];

