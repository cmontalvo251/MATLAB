clear
clc
close all

global throttle
global theta
global FuelCons
global Power

parameters

%%%Change this for the specific parameter
global CD
CD = 0.145;
var_vec = linspace(CD*0.1,CD*6,10);
%var_vec = [0.001947]; %290.4
%var_vec = 0.002221; %224.1
%var_vec = 0.002206; %321.4
FUELECON_VEC = 0*var_vec;

%%%%%Make wrapper for a specific variable
for var = 1:length(var_vec)
    
    throttle = 0;
    theta = 0;
    FuelCons = 0;
    Power = 0;
    
    %%%Change this for every parameter
    var
    CD = var_vec(var)

%%%Time vector
dt = 0.5;
time = 0:dt:400;

%%%Initial Conditions
xstate = zeros(3,length(time));
throttle_vec = zeros(1, length(time));
theta_vec= zeros(1,length(time));
fuel_vec= zeros(1,length(time));
x0 = [0 0 0]'; % x, u, rpm, 
xcar = Lcar/2;
xstate(:,1) = x0;

%NEED TO ADD IN WHILE LOOP TO RUN TO END OF TRACK
%while x <= 2570.4911
for k = 1:length(time)-1
    %%%Runge_Kutta
    xk = xstate(:,k);
    tk = time(k);
    k1 = Derivatives(xk,tk);
    k2 = Derivatives(xk+k1*dt/2,tk+dt/2);
    k3 = Derivatives(xk+k2*dt/2,tk+dt/2);
    k4 = Derivatives(xk+k3*dt,tk+dt);
    phi = (1/6)*(k1 + 2*k2 + 2*k3 + k4);
    xstate(:,k+1) = xstate(:,k) + phi*dt;
    throttle_vec(k+1)=throttle;
    theta_vec(k+1)=theta;
    fuelcons=FuelCons*dt; %gallons consumed
    fuel_vec(k+1)= fuelcons;
    Power_vec(k+1)=Power;
end

x = xstate(1,:);
u = xstate(2,:);
RPM = xstate(3,:)+ 2200;
TOTALFUEL= sum(fuel_vec);
FUELECON= (max(x)/TOTALFUEL)/1609.34 %Meter/Gal to MPG

FUELECON_VEC(var) = FUELECON;

end
FUELECON_VEC
plot(var_vec,FUELECON_VEC)

FUELECON_STD = std(FUELECON_VEC)

break

fig = figure;
set(gca,'FontSize',18)
plot(time,x,'b-','LineWidth',2)
hold on
xlabel('Time, s')
ylabel('Position, m')

fig = figure;
set(gca,'FontSize',18)
plot(time,u,'b-','LineWidth',2)
hold on
xlabel('Time, s')
ylabel('Velocity, m/s')

fig = figure;
set(gca,'FontSize',18)
plot(time,RPM,'b-','LineWidth',2)
hold on
xlabel('Time, s')
ylabel('Engine Speed, rpm')

fig = figure;
set(gca,'FontSize',18)
plot(time,throttle_vec,'b-','LineWidth',2)
hold on
xlabel('Time, s')
ylabel('Throttle, %')

fig = figure;
set(gca,'FontSize',18)
plot(time,theta_vec,'b-','LineWidth',2)
hold on
xlabel('Time, s')
ylabel('Angle of Incline, \theta')

fig = figure;
set(gca,'FontSize',16)
plot(time,fuel_vec,'b-','LineWidth',2)
hold on
xlabel('Time, s')
ylabel('Fuel Consumption, gal/s')

fig = figure;
set(gca,'FontSize',16)
plot(time,Power_vec/745.7,'b-','LineWidth',2)
hold on
xlabel('Time, s')
ylabel('Power, Hp')
axis([0 400 0 16])

%save_plots
