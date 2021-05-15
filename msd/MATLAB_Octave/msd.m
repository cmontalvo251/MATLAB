function msd()
clc
close all

disp('Mass Spring Damper Program')
%Initialize State Vector
State = [1;-2]; %%% 1 DOF - 2 States - x xdot or position and velocity
%Initliaze StateDot Vector
StateDot = Derivatives(State,0);
%Define TIME Variables
tfinal = 10;
tinitial = 0;
timestep = 0.1;
time = tinitial:timestep:tfinal;
%Pre-allocate StateOUT
StateOUT = zeros(2,length(time));
ucontrol = zeros(length(time),1);
for idx = 1:length(time)
  StateOUT(:,idx) = State;
  %%Compute k1
  u1 = Control(State,time(idx));
  k1 = Derivatives(State,u1);
  %%Compute k2
  u2 = Control(State+k1*timestep/2,time(idx)+timestep/2);
  k2 = Derivatives(State+k1*timestep/2,u2);
  %%Compute k3
  u3 = Control(State+k2*timestep/2,time(idx)+timestep/2);
  k3 = Derivatives(State+k2*timestep/2,u3);
  %%Compute k4
  u4 = Control(State+k3*timestep,time(idx)+timestep);
  k4 = Derivatives(State+k3*timestep,u4);
  %%Compute phi
  phi = (1/6)*(k1 + 2*k2 + 2*k3 + k4);
  %%Statep State
  State = State + phi*timestep;
  ucontrol(idx) = u1;
end

fig = figure();
set(fig,'color','white')
plot(time,ucontrol,'b-','LineWidth',2)
set(gca,'FontSize',18)
xlabel('Time (sec)')
ylabel('Force of Control (N)')
grid on

position = StateOUT(1,:);
velocity = StateOUT(2,:);

fig = figure();
set(fig,'color','white')
plot(time,position,'b-','LineWidth',2)
set(gca,'FontSize',18)
xlabel('Time (sec)')
ylabel('Position (m)')
grid on

fig = figure();
set(fig,'color','white')
plot(time,velocity,'b-','LineWidth',2)
set(gca,'FontSize',18)
xlabel('Time (sec)')
ylabel('Velocity (m/s)')
grid on

function StateDot = Derivatives(State,ucontrol)
m = 1;
c = 2;
k = 3;
A = [0 1;-k/m -c/m];
B = [0;1/m];
%Compute STateDot = A*State+B*ucontrol
StateDot = A*State + B*ucontrol;

function ucontrol = Control(State,t)
kp = 30;
kd = 10;
xcommand = 1;
xdotcommand = 0;
ucontrol = 0;
if t > 5
  ucontrol = -kp*(State(1) - xcommand) - kd*(State(2) - xdotcommand);
end
