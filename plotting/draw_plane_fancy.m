function draw_plane_fancy(state,xyzf,xyzL,xyzR,xyzp,wingspan,time,jj)

if ~exist('xyzL','var')
    wingspan = xyzf;
    [xf,yf,zf]=stlread('Fuselage.STL');
    [xL,yL,zL]=stlread('LWing.STL');
    [xR,yR,zR]=stlread('RWing.STL');
    [xp,yp,zp]=stlread('Prop.STL');
    xyzf = [xf;yf;zf];
    xyzL = [xL;yL;zL];
    xyzR = [xR;yR;zR];
    xyzp = [xp;yp;zp];
    STLREAD = 1;
end

if ~exist('jj','var')
  jj = 10;
end

if length(wingspan) == 3
  SF1 = wingspan(1)/0.6;
  SF2 = wingspan(2)/0.6;
  SF3 = wingspan(3)/0.6;
else
  SF1 = wingspan/0.6;
  SF2 = SF1;
  SF3 = SF1;
end
SF = [SF1;SF2;SF3];


%%Unwrap States

x = state(1);
y = state(2);
z = state(3);

ph = state(4)+pi;
th = state(5);
ps = state(6);

lh = 0;
rh = 0;

pos = [x y z]';
att = [ph th ps]';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xyzf=xyzf;
xyzL=xyzL;
xyzR=xyzR;
%%Unwrap Plane parameters
xf = xyzf(1:3,:);
yf = xyzf(4:6,:);
zf = xyzf(7:9,:);
xL = xyzL(1:3,:);
yL = xyzL(4:6,:);
zL = xyzL(7:9,:);
xR = xyzR(1:3,:);
yR = xyzR(4:6,:);
zR = xyzR(7:9,:);
xp = xyzp(1:3,:);
yp = xyzp(4:6,:);
zp = xyzp(7:9,:);

% center fuselage
Xf = -xf+.16074716;
%Xf = -xf+.26074716;
%Xf = -xf+.31074716;
Yf = zf-.1;
Zf = yf-0.025973275-.0075311;

xshift = -0.05;
%xshift = -0.15;
%xshift = -0.20;
% position Left wing
XL = zL+xshift;
YL = xL-.6096/2;
ZL = yL;
[XL,YL,ZL] = transform_body(XL,YL,ZL,[0 0 0]',[lh 0 pi]',[1;1;1]);
ZL = ZL-.0075311;

% position right wing
XR = zR+xshift;
YR = xR;
ZR = yR;
[XR,YR,ZR] = transform_body(XR,YR,ZR,[0 0 0]',[rh 0 pi]',[1;1;1]);
ZR = ZR-.0075311;

% position Prop
Xp = xp+.161;
Yp = yp-.008480552;
Zp = zp-0.06096;
if ~exist('time','var')
    time = 0;
end
[Xp,Yp,Zp] = transform_body(Xp,Yp,Zp,[0 0 0]',[10*pi/3*time 0 0]',[1;1;1]);
Zp = Zp-.0075311;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Transform Body
%att = [0;0;0];
[Xf,Yf,Zf] = transform_body(Xf,Yf,Zf,pos,att,SF);
[XL,YL,ZL] = transform_body(XL,YL,ZL,pos,att,SF);
[XR,YR,ZR] = transform_body(XR,YR,ZR,pos,att,SF);
[Xp,Yp,Zp] = transform_body(Xp,Yp,Zp,pos,att,SF);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%rgb
if jj == 10
  fcolor = [1 0.843 0];
  wcolor = [0 0 0];
elseif jj == 2
  fcolor = [0.5 0.5 0.5];
  wcolor = [0.5 0.5 0.5];
elseif jj == 1
  fcolor = [0 0 0];
  wcolor = [0 0 0];
else
  fcolor = [0.5 0.5 0.5];
  wcolor = [0 0 0];
end

%%Actually Draw Plane Now%%%%%%%%%%%%%%%%%%%%%%%

edgecolor = 'none';
%edgecolor = [0 0 0];
%fcolor = 'none';
%wcolor = 'none';

Fuse = patch(Xf,Yf,Zf,Zf,'edgecolor',edgecolor,'facecolor',fcolor);
hold on
LWing = patch(XL,YL,ZL,ZL,'edgecolor',edgecolor,'facecolor',wcolor);
RWing = patch(XR,YR,ZR,ZR,'edgecolor',edgecolor,'facecolor',wcolor);
%Prop = patch(Xp,Yp,Zp,Zp,'edgecolor',edgecolor,'facecolor',[.4 .4 .6]);
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
