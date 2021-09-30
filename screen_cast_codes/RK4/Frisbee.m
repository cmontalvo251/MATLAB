function Frisbee()
purge

%%%Initial Conditions
x0 = 0;
z0 = -10;

phi0 = 0;
theta0 = pi/10;
psi0 = 0;

u0 = 5;
w0 = 0.1;

p0 = 0;
q0 = 0;
r0 = 10;

state0 = [x0,z0,phi0,theta0,psi0,u0,w0,p0,q0,r0]';

%%%Time vector
timestep = 0.01;
tfinal = 10;

time = 0:timestep:tfinal;

%%%RK4 Loop
state = zeros(10,length(time));

%%%DrawFrisbee
plottool(1,'Frisbee',18,'x','y','z')
tic
for idx = 1:length(time)
    
    %%%
    while toc < time(idx)
        cla;
        DrawFrisbee(1/3.28,1/3.28,0.1/3.28,state0(1),0,state0(2),state0(3),state0(4),state0(5));
        view(-27,50)
        xlim([state0(1)-1 state0(1)+1])
        ylim([-1 1])
        zlim([state0(2)-1 state0(2)+1])
        reverse(['z','y'])
        drawnow
    end

    %Save state
    state(:,idx) = state0;
    t = time(idx)
    
    %Deriv call
    k1 = Derivative(state0,t);
    k2 = Derivative(state0+k1*timestep/2,t+timestep/2);
    k3 = Derivative(state0+k2*timestep/2,t+timestep/2);
    k4 = Derivative(state0+k3*timestep,t+timestep);
    
    %Step State
    rk4 = (1/6)*(k1+2*k2+2*k3+k4);
    state0 = state0 + rk4*timestep;
end

%Plots
%Plot6(1:12,{time},state',1,'m');

function statedot = Derivative(state,t)

%States
x = state(1);
z = state(2);
phi = state(3);
theta = state(4);
psi = state(5);
u = state(6);
w = state(7);
p = state(8);
q = state(9);
r = state(10);

%Kinematics (Linear)
xdot = cos(theta)*u + sin(theta)*w;
zdot = -sin(theta)*u + cos(theta)*w;

%Kinematics (Rotational)
sphi = sin(phi);
ttheta = tan(theta);
cphi = cos(phi);
ctheta = cos(theta);
H = [1 sphi*ttheta cphi*ttheta;0 cphi -sphi;0 sphi/ctheta cphi/ctheta];
ptpdot = H*[p,q,r]';

%Parameters
m = 175/1000; %%kg
radius = 1/3.28;
A = m*radius^2/4;
C = m*radius^2/2;

%Aerodynamics
Zw = -5;
d = radius/4;
Malfa = -Zw*w*d;

%Dynamics (Linear)
udot = 0;
wdot = (Zw*w)/m;

%Dynamics (Rotational)
pdot = (1/A)*(r*A*q - q*C*r);
qdot = (1/A)*(Malfa - r*A*p + p*C*r);
rdot = (1/C)*(q*A*p - p*A*q);    

statedot = [xdot;zdot;ptpdot;udot;wdot;pdot;qdot;rdot];

