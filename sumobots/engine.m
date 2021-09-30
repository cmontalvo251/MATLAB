close all
clear all

% Initial time is zero
t = 0;

% Load engine settings
engine_settings

% Add path
addpath('bots');
rehash

% Construct array of bots
c = 0;
fid = fopen('player_list.txt','r');
figure()
pause
while 1
   a = fgets(fid);

   if numel(a)==1
       if a==-1
           break
       end
   end
   c = c+1;
   w = find(a==' ');

   bot = struct;
   botarray{c} = bot;
   botarray{c}.name = a(1:(w-1));
   clear botarray{c}.name
   botarray{c}.color = a((w+1));
   str = ['botarray{c}.fun = @' botarray{c}.name ';'];
   eval(str)
end
fclose(fid);

% Count number of players
n = numel(botarray);

% Set up initial game state
for i = 1:n
   %botarray{i}.state = [R_start*cos(2*pi*(i-1)/n); R_start*sin(2*pi*(i-1)/n); 0;0];
   botarray{i}.state = [R_start*cos(2*pi*(i-1)/n); R_start*sin(2*pi*(i-1)/n); (rand-0.5)/2; (rand-0.5)/2];
end

% Main loop
while 1

    % Get next game state
    [t, botarray] = next_step(t,dt,botarray);

    % Check to see if bot is outside playing surface
    % Remove bot if necessary
    for i = 1:n
        try
        if norm(botarray{i}.state(1:2))>world_radius(t);

            c = 0;
            for j = 1:n
                if j~=i
                    c = c+1;
                    newbotarray{c} = botarray{j};

                end
            end

            botarray = newbotarray;
            clear newbotarray;

            n = numel(botarray)
        end
        end
    end

    % Plot
    plot_bots(t,botarray);
    title(num2str(t))

    if n<2
        break
    end

end

% End of game
if n==1
    title([botarray{1}.name ' Wins!   ' num2str(t)])
    fprintf(botarray{1}.name)
    fprintf('\n')
end



