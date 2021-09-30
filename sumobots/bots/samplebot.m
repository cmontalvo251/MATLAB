function u = samplebot(t,state,botarray)
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
%           If you want to know the x velocity of the 2nd bot in the list:
%           bot2_xvel = botarray{2}.state(3)
%
%           Notice the use of curly brackets above.
%
%           Output is 2x1 control vector.  
% u:        2x1 vector containing accelerations in x and y respectively

x = state(1);
y = state(2);

u = -[x; y];  %Accelerate toward the center of the circle
