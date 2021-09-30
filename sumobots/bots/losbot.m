function u = losbot(t,state,botarray)

xpos = state(1);
ypos = state(2);
xvel = state(3);
yvel = state(4);

n = numel(botarray);

%%%Find Enemy
myname = 'losbot';
enemy = n; 
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

u1 = -u_max*sign(xpos);
u2 = -u_max*sign(ypos);

u = [u1 u2]';