function u = testbot(t,state,botarray)

xpos = state(1);
ypos = state(2);
xvel = state(3);
yvel = state(4);

n = numel(botarray);

%%%Find Enemies
myname = 'testbot';
enemy = [];
for i = 1:n
  botcolor = botarray{i}.name;
  if ~strcmp(botcolor,myname)
    enemy = [enemy i];
  end
end
oneteam = 0;
if length(enemy) == 1
  oneteam = 1;
end
if length(enemy) == 0 %%you won
  enemy = [n];
  oneteam = 0;
end

%%Search for closest enemy
distance = [];
for i = 1:length(enemy)
  xenem = botarray{enemy(i)}.state(1);
  yenem = botarray{enemy(i)}.state(2);
  distance = [distance norm([(ypos - yenem) (xpos-xenem)])];
end
enemy = enemy(find(distance == min(distance),1));

xenem = botarray{enemy}.state(1);
yenem = botarray{enemy}.state(2);
xdotenem = botarray{enemy}.state(3);
ydotenem = botarray{enemy}.state(4);
renemy = norm([xenem yenem]);
thetae = atan2(yenem,xenem);
engine_settings;

%%commands
xdbldotc = 0;
ydbldotc = 0;

veltotal = norm([xvel yvel]);
postotal = norm([xpos ypos]);
Vrecover = sqrt(2*u_max*(world_R-abs(postotal)));
safe = 0.7;

if veltotal > safe*Vrecover
   xc = 0;
   yc = 0;
   ydotc = 0;
   xdotc = 0;
   Kpx = 20;
   Kpy = 20;
   %%Gains (critically damped)
   Kdx = 2*sqrt(Kpx);
   Kdy = 2*sqrt(Kpy);
   Kdx = 0;Kdy = 0;
   udivert1 = 0;
   udivert2 = -yenem;
   u1 = xdbldotc + Kdx*(xdotc - xvel) + Kpx*(xc - xpos) + udivert1;
   u2 = ydbldotc + Kdy*(ydotc - yvel) + Kpy*(yc - ypos) + udivert2;
else
  if oneteam
     thetac = 0;
     if renemy < postotal
        thetac = pi/5;
     end
     xc = renemy*cos(thetae + thetac);
     yc = renemy*sin(thetae + thetac);
     ydotc = 0;
     xdotc = 0;
     Kpx = 20;
     Kpy = 20;
     Kdx = 0;
     Kdy = 0;
     udivert1 = 0;
     udivert2 = 0;
%      if postotal > renemy
%         udivert1 = -(xpos-xenem);
%         udivert2 = (ypos-yenem);
%      end
     u1 = xdbldotc + Kdx*(xdotc - xvel) + Kpx*(xc - xpos)+udivert1;
     u2 = ydbldotc + Kdy*(ydotc - yvel) + Kpy*(yc - ypos)+udivert2;
  else %%there are multiple enemies
     xc = xenem;
     yc = yenem;
     ydotc = 0;
     xdotc = 0;
     Kpx = 0.5;
     Kpy = 0.5;
     Kdx = 2*sqrt(Kpx);
     Kdy = 2*sqrt(Kpy);
     udivert1 = 0;
     udivert2 = 0;
     if postotal > norm([xenem yenem])
        udivert1 = -(xpos-xenem);
        udivert2 = (ypos-yenem);
     end
     u1 = xdbldotc + Kdx*(xdotc - xvel) + Kpx*(xc - xpos)+udivert1;
     u2 = ydbldotc + Kdy*(ydotc - yvel) + Kpy*(yc - ypos)+udivert2;
  end
end
u = [u1 u2]';
