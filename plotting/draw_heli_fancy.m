function draw_heli_fancy(state,xyzh,scale,fcolor)

SF = scale;

%%Unwrap States

x = state(1);
y = state(2);
z = state(3);

ph = state(4)+pi;
th = state(5);
ps = state(6)+pi/2;

lh = 0;
rh = 0;

pos = [x y z]';
att = [ph th ps]';

%%Unwrap Heli parameters
xh = xyzh(1:3,:);
yh = xyzh(4:6,:)+2;
zh = xyzh(7:9,:);

[Xh,Yh,Zh] = transform_body(xh,yh,zh,pos,att,SF);



%%Actually Draw Heli Now%%%%%%%%%%%%%%%%%%%%%%%

edgecolor = 'none';

heli = patch(Xh,Yh,Zh,Zh,'edgecolor',edgecolor,'facecolor',fcolor);


% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
