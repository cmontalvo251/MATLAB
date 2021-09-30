function u = kyleBot(t,state,botarray)
% This MATLAB function represents a SumoBot.  The input arguments are:
%
% t:        current time (seconds)
%
% state:    4x1 vector containing current state of THIS bot
%           state(1) = x position
%           state(2) = y position
%           state(3) = x velocity
%           state(4) = y velocity
%
% botarray: a cell array of structures containing info on other bots
%           You can calculate the number of other bots as follows:
%           n = numel(botarray);
%
%           If you want to access the state vector of the 3rd bot:
%           bot3state = botarray{3}.state
%
%           Notice the use of curly brackets above.
%
%           Output is 2x1 control vector.  
% u:        2x1 vector containing accelerations in x and y respectively

engine_settings;

kp = 32*u_max/world_R;
zeta = 0.6;
kd = 2*zeta*sqrt(kp);

enemystate = botarray{1}.state;

enemyr = norm(enemystate(1:2));
enemyrHat = enemystate(1:2)./enemyr;

if t < 1
    stateCommanded = zeros(4,1);
else
    stateCommanded = [enemystate(1:2)-1.2*bot_R.*enemyrHat; enemystate(3:4)];
end

stateError = state - stateCommanded;

u = [-kp 0 -kd 0; 0 -kp 0 -kd]*stateError;                            
