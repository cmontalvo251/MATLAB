bot_R = 1;                      % radius of each bot
spring_K = 150;                 % spring constant for collisions
u_max = 1;                      % Control saturation
u_tail = 1;                     % Length of u plot
world_R = world_radius(t);      % Radius of the playing surface
R_start = world_radius(0)/2;    % Starting radius
dt = 0.1;                       % Timestep for integration
