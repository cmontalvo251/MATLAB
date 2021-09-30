clear
close all
clc

%%%%3D array won't work but a cell array will
T_all = {};

%%%MAKE A BIGGGGG LOOP AROUND K
% heat constant
k = linspace(2,30,5); %%%Be careful. THis is going to make 5 figures
for ki = k
disp(ki)

% length of the body
L = 50;

% number of elements
N = 100;

% discretize the space
x_vec = linspace(0,L,N);
dx = x_vec(2) - x_vec(1);

% dicretize the time
dt = 0.1*(dx^2)/(2*ki); %%%instead of using alpha here we use ki
t_vec = 0:dt:20;

% allocate memory
T_sol = zeros(length(x_vec), length(t_vec));

% initial codition
T_sol(1,:) = 300; %left side of the body temp
T_sol(end,:) = 600; %right side of the body temp

for tdt = 1:length(t_vec) - 1 % time loop
    for xdx = 2:length(x_vec) - 1 % spce loop
        T_sol(xdx,tdt+1) = T_sol(xdx,tdt) + ki*dt/(dx^2) * ( T_sol(xdx+1,tdt) - 2*T_sol(xdx,tdt) + T_sol(xdx-1,tdt) );
    end
end

% plot

[tt,xx] = meshgrid(t_vec,x_vec);

%%%In order to get a new figure everytime we use the function figure()
figure()
mesh(xx,tt,T_sol)

xlabel('x coordinate (m)')
ylabel('y coordinate time (s)')
zlabel('Temperature (C)')
rotate3d on

%%%%Contatenate array to T_all
T_all = [T_all;T_sol];

end %%%end the BIGGGG LOOP on K
