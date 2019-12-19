%%%% dT/dt = k*d^2T/dx^2 - partial derivatives

%%% T = temperature = f(x,t)

%%% time derivative = second spatial derivative

%%%( T(x,t+dt) - T(x,t) ) / dt = k*( T(x+dx,t) - 2*T(x,t) + T(x-dx,t) ) / dx^2

%%% Tdot = k*( T(x+dx,t) - 2*T(x,t) + T(x-dx,t) ) / dx^2

%%% k1 = Tdot(T)
%%% k2 = Tdot(T+k1*dt/2)
%%% etc etc


%%% Propagate this system in time

%%% Solve for T(x,t+dt) = T(x,t) + k*dt/dx^2 * ( T(x+dx,t) - 2*T(x,t) + T(x-dx,t))

function finite_difference_example()
global x_vec dx k
 
clc
close all

%%% Heat Constant - Heat Capacitance 
k = 2;

%%%Length of the pipe
L = 10;

%%%Number of Elements
N = 10;

%%%Discretize our Xspace
x_vec = linspace(0,L,N); %%%start at 0, increment to L and the length of the vector is N
dx = x_vec(2)-x_vec(1); %%%consequence of the linspace command

%%%Discretize time
dt = 1.0*(dx^2)/(2*k)
t_vec = 0:dt:10;

%%%Allocate memory for Temp
T_mat = zeros(length(x_vec),length(t_vec)); 

%%% Initial Conditions for the Temperature of the pipe
T_mat(1,:) = 200; %%%the left end of the pipe is 200 degrees - Boundary condition
T_mat(end,:) = 150; %%%The rigt end of the pipe is 150 degree - BCs

%%% Integrate using Euler's and FDM put together
for tdx = 1:length(t_vec)-1 %%%integrator integrates to tdx+1
    for idx = 2:length(x_vec)-1
        T_mat(idx,tdx+1) = T_mat(idx,tdx) + k*dt/(dx^2) * ( T_mat(idx+1,tdx) - 2*T_mat(idx,tdx) + T_mat(idx-1,tdx));
    end
end

%%%% Plot this
[tt,xx] = meshgrid(t_vec,x_vec);

mesh(xx,tt,T_mat)

xlabel('X coordinate (m)')
ylabel('Time (sec)')
zlabel('Temperature (F)')

dtRK4 = 1.4*(dx^2)/(2*k)

tRK4_vec = t_vec(1):dtRK4:t_vec(end);

%%%% Make a new T_mat because the vector sizes have changed
TRK4_mat = zeros(length(x_vec),length(tRK4_vec)); 
TRK4_mat(1,:) = 200; %%%the left end of the pipe is 200 degrees - Boundary condition
TRK4_mat(end,:) = 150; %%%The rigt end of the pipe is 150 degree - BCs

for tdx = 1:length(tRK4_vec)-1
    %%%Standard RK4 equation
    k1 = Derivative(TRK4_mat(:,tdx));
    k2 = Derivative(TRK4_mat(:,tdx)+k1*dtRK4/2);
    k3 = Derivative(TRK4_mat(:,tdx)+k2*dtRK4/2);
    k4 = Derivative(TRK4_mat(:,tdx)+k3*dtRK4);
    phi = (1/6)*(k1 + 2*k2 + 2*k3 + k4);
    TRK4_mat(:,tdx+1) = TRK4_mat(:,tdx) + phi*dtRK4;    
end

%%%% Plot this
[tt,xx] = meshgrid(tRK4_vec,x_vec);

figure()
mesh(xx,tt,TRK4_mat)

xlabel('X coordinate (m)')
ylabel('Time (sec)')
zlabel('Temperature (F)')

function dTdt = Derivative(Tin_vec)
global x_vec dx k

dTdt = 0*Tin_vec;

for idx = 2:length(x_vec)-1
    dTdt(idx) = k/(dx^2) * ( Tin_vec(idx+1) - 2*Tin_vec(idx) + Tin_vec(idx-1));
end




