function u = pass(t,state,botarray)

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

xpos = state(1);
ypos = state(2);
xvel = state(3);
yvel = state(4);

n = numel(botarray);
%%%Find Enemy
%%Assume I'm blue
myname = 'passive';
enemy = n; %%Just in case there is no color
for i = 1:n
  botcolor = botarray{i}.name;
  if ~strcmp(botcolor,myname)
    enemy = i;
    break;
  end
end

xenem = botarray{enemy}.state(1);
yenem = botarray{enemy}.state(2);
xdotenem = botarray{enemy}.state(3);
ydotenem = botarray{enemy}.state(4);
engine_settings;
world_R = world_R/2;

xc = xenem;
yc = yenem;
Kpx = 0.5;
Kpy = 0.5;
xdotc = xdotenem;
ydotc = ydotenem;
if norm([xpos ypos]) > 0.8*world_R
  xc = 0;
  yc = 0;
  ydotc = 0;
  xdotc = 0;
  Kpx = 20;
  Kpy = 20;
end

%%commands
xdbldotc = 0;
ydbldotc = 0;

%%Gains (critically damped)
Kdx = 2*sqrt(Kpx);
Kdy = 2*sqrt(Kpy);


u1 = xdbldotc + Kdx*(xdotc - xvel) + Kpx*(xc - xpos);
u2 = ydbldotc + Kdy*(ydotc - yvel) + Kpy*(yc - ypos);

u = [u1 u2]';
