function u = kyleBot_v2(t,state,botarray)
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

x = state(1);
y = state(2);
u = state(3);
v = state(4);

bot1state = botarray{1}.state;

engine_settings;

kp = 8*u_max/world_R;
kd = 2*sqrt(kp);

fIdeal = u_max*1;

r = norm([x; y]);

rHat = [x y]'./r;
tHat = [0 -1; 1 0]*rHat;

rdot = dot([u; v],rHat);
tdot = dot([u; v],tHat);

rc = world_R*0.8/2;

rError = r-rc;
rdotError = rdot - 0;

tdotError = tdot - sqrt(fIdeal*r);

ut = (-kp*rError -kd*rdotError -tdot^2/r).*rHat;
ur = (-tdotError).*tHat;  

u = ut + ur;                            
