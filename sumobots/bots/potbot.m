function u = potbot(t,state,botarray)
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
%           bot3 = botarray{3}.state
%
%           Notice the use of curly brackets above.
%
%           Output is 2x1 control vector.  
% u:        2x1 vector containing accelerations in x and y respectively

engine_settings;

x = state(1);
y = state(2);
u = state(3);
v = state(4);

pos = [x; y];
vel = [u; v];

del = 0.01;
v_c = -[(pot(pos+[del; 0],botarray,t,vel)-pot(pos,botarray,t,vel))/del ;...
       (pot(pos+[0; del],botarray,t,vel)-pot(pos,botarray,t,vel))/del]/2;

v_e = v_c-vel;

u = v_e;
   
end


function out = pot(pos,botarray,t,vel)

x = pos(1);
y = pos(2);

out = 0;

engine_settings;
if norm(pos)>world_R*3/4
    out =  ((x^2 + y^2)^3) - vel(1)*x - vel(2)*y;
end


for i = 1:numel(botarray)
    pos2 = [botarray{i}.state(1); botarray{i}.state(2)];
   out = out - (1000-norm((pos2-pos))^2); 
end


end