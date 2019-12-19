function xdot = total_derivative(t,botarray)
% Equations of motion for the game.  Includes collision dynamics and a call
% to each of the bots for control inputs.

engine_settings;

% Number of bots:
n = numel(botarray);

% Position vector:
x = zeros(2*n,1);

% Velocity vector:
v = zeros(2*n,1);

% Accelerations vector
a_vec = zeros(2*n,1);


% Populate x and v using botarray
state = botarray2state(botarray);
x = state(1:(2*n));
v = state((2*n+1):end);

% Calculate accelerations due to collisions

for i = 1:n
    for j = (i+1):n

        % Calculate position from bot i to bot j
        Rij = [botarray{j}.state(1)-botarray{i}.state(1);...
            botarray{j}.state(2)-botarray{i}.state(2)];

        % Detect a collision
        if norm(Rij)<=2*bot_R

            % Calculate contact "force" on j due to i
            Fij_mag = spring_K*(2*bot_R-norm(Rij))^2;
            Fij = Fij_mag * Rij./norm(Rij);

            % Add equal and opposite accelerations to the bots
            a_vec((2*(j-1)+1):(2*(j-1)+2)) = a_vec((2*(j-1)+1):(2*(j-1)+2)) + Fij;
            a_vec((2*(i-1)+1):(2*(i-1)+2)) = a_vec((2*(i-1)+1):(2*(i-1)+2)) - Fij;


        end

    end
end

for i = 1:n

    % Construct an array of bots
    c = 0;
    for j = 1:n
        if j ~= i
            c = c+1;
            newbotarray{c} = botarray{j};
            % Remove function handle
            newbotarray{c}.fun = [];

        end
    end

    % Call the bot function
    u = feval(botarray{i}.fun,  t, botarray{i}.state , newbotarray );

    % Control saturation
    if norm(u)>u_max
        u = u/norm(u)*u_max;
    end

    % Apply the control to the acceleration vector
    a_vec((2*(i-1)+1):(2*(i-1)+2)) = a_vec((2*(i-1)+1):(2*(i-1)+2)) + u;
end

xdot = [v; a_vec];
