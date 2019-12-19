clear all
close all
clc

FidState(1) = fopen('MArtie_State_botT12.OUT');

k =1;
ns = 79;

[data,count] = fscanf(FidState(k),'%g');
n(k) = count/ns;
i = [0:n(k)-1];
j = [1:max(size(i))];
t(j,k) = data(ns*i+1);
xfuse(j,k) = data(ns*i+2);
yfuse(j,k) = data(ns*i+3);
zfuse(j,k) = data(ns*i+4);
q0fuse(j,k) = data(ns*i+5);
q1fuse(j,k) = data(ns*i+6);
q2fuse(j,k) = data(ns*i+7);
q3fuse(j,k) = data(ns*i+8);
ufuse(j,k) = data(ns*i+9);
vfuse(j,k) = data(ns*i+10);
wfuse(j,k) = data(ns*i+11);
pfuse(j,k) = data(ns*i+12);
qfuse(j,k) = data(ns*i+13);
rfuse(j,k) = data(ns*i+14);
xlw(j,k) = data(ns*i+15);
ylw(j,k) = data(ns*i+16);
zlw(j,k) = data(ns*i+17);
q0lw(j,k) = data(ns*i+18);
q1lw(j,k) = data(ns*i+19);
q2lw(j,k) = data(ns*i+20);
q3lw(j,k) = data(ns*i+21);
ulw(j,k) = data(ns*i+22);
vlw(j,k) = data(ns*i+23);
wlw(j,k) = data(ns*i+24);
plw(j,k) = data(ns*i+25);
qlw(j,k) = data(ns*i+26);
rlw(j,k) = data(ns*i+27);
xrw(j,k) = data(ns*i+28);
yrw(j,k) = data(ns*i+29);
zrw(j,k) = data(ns*i+30);
q0rw(j,k) = data(ns*i+31);
q1rw(j,k) = data(ns*i+32);
q2rw(j,k) = data(ns*i+33);
q3rw(j,k) = data(ns*i+34);
urw(j,k) = data(ns*i+35);
vrw(j,k) = data(ns*i+36);
wrw(j,k) = data(ns*i+37);
prw(j,k) = data(ns*i+38);
qrw(j,k) = data(ns*i+39);
rrw(j,k) = data(ns*i+40);
xfuse_dot(j,k) = data(ns*i+41);
yfuse_dot(j,k) = data(ns*i+42);
zfuse_dot(j,k) = data(ns*i+43);
q0fuse_dot(j,k) = data(ns*i+44);
q1fuse_dot(j,k) = data(ns*i+45);
q2fuse_dot(j,k) = data(ns*i+46);
q3fuse_dot(j,k) = data(ns*i+47);
ufuse_dot(j,k) = data(ns*i+48);
vfuse_dot(j,k) = data(ns*i+49);
wfuse_dot(j,k) = data(ns*i+50);
pfuse_dot(j,k) = data(ns*i+51);
qfuse_dot(j,k) = data(ns*i+52);
rfuse_dot(j,k) = data(ns*i+53);
xlw_dot(j,k) = data(ns*i+54);
ylw_dot(j,k) = data(ns*i+55);
zlw_dot(j,k) = data(ns*i+56);
q0lw_dot(j,k) = data(ns*i+57);
q1lw_dot(j,k) = data(ns*i+58);
q2lw_dot(j,k) = data(ns*i+59);
q3lw_dot(j,k) = data(ns*i+60);
ulw_dot(j,k) = data(ns*i+61);
vlw_dot(j,k) = data(ns*i+62);
wlw_dot(j,k) = data(ns*i+63);
plw_dot(j,k) = data(ns*i+64);
qlw_dot(j,k) = data(ns*i+65);
rlw_dot(j,k) = data(ns*i+66);
xrw_dot(j,k) = data(ns*i+67);
yrw_dot(j,k) = data(ns*i+68);
zrw_dot(j,k) = data(ns*i+69);
q0rw_dot(j,k) = data(ns*i+70);
q1rw_dot(j,k) = data(ns*i+71);
q2rw_dot(j,k) = data(ns*i+72);
q3rw_dot(j,k) = data(ns*i+73);
urw_dot(j,k) = data(ns*i+74);
vrw_dot(j,k) = data(ns*i+75);
wrw_dot(j,k) = data(ns*i+76);
prw_dot(j,k) = data(ns*i+77);
qrw_dot(j,k) = data(ns*i+78);
rrw_dot(j,k) = data(ns*i+79);

alphafuse(j,k) = atan2(data(ns*i+11),data(ns*i+9));
velfuse(j,k) = sqrt(data(ns*i+9).^2+data(ns*i+10).^2+data(ns*i+11).^2);

alphalw(j,k) = atan2(data(ns*i+24),data(ns*i+22));
vellw(j,k) = sqrt(data(ns*i+22).^2+data(ns*i+23).^2+data(ns*i+24).^2);

alpharw(j,k) = atan2(data(ns*i+37),data(ns*i+35));
velrw(j,k) = sqrt(data(ns*i+35).^2+data(ns*i+36).^2+data(ns*i+37).^2);

phifuse(j,k) = atan2(2*(data(ns*i+5).*data(ns*i+6)+data(ns*i+7).*data(ns*i+8)), 1-2*((data(ns*i+6)).^2+(data(ns*i+7)).^2));
thetafuse(j,k) = asin(2*(data(ns*i+5).*data(ns*i+7)-data(ns*i+8).*data(ns*i+6)));
psifuse(j,k) = atan2(2*(data(ns*i+5).*data(ns*i+8)+data(ns*i+6).*data(ns*i+7)),1-2*((data(ns*i+7)).^2+(data(ns*i+8)).^2));

philw(j,k) = atan2(2*(data(ns*i+18).*data(ns*i+19)+data(ns*i+20).*data(ns*i+21)), 1-2*((data(ns*i+19)).^2+(data(ns*i+20)).^2));
thetalw(j,k) = asin(2*(data(ns*i+18).*data(ns*i+20)-data(ns*i+21).*data(ns*i+19)));
psilw(j,k) = atan2(2*(data(ns*i+18).*data(ns*i+21)+data(ns*i+19).*data(ns*i+20)),1-2*((data(ns*i+20)).^2+(data(ns*i+21)).^2));

phirw(j,k) = atan2(2*(data(ns*i+31).*data(ns*i+32)+data(ns*i+33).*data(ns*i+34)), 1-2*((data(ns*i+32)).^2+(data(ns*i+33)).^2));
thetarw(j,k) = asin(2*(data(ns*i+31).*data(ns*i+33)-data(ns*i+34).*data(ns*i+32)));
psirw(j,k) = atan2(2*(data(ns*i+31).*data(ns*i+34)+data(ns*i+32).*data(ns*i+33)),1-2*((data(ns*i+33)).^2+(data(ns*i+34)).^2));

plottool(1,'Name',12,'x','y','z');
tstart = find(t>25,1);
%tstart = 1;
for i = tstart:length(t)
  cla
  view(-27,30)
  CubeDraw(0.41,0.06,0.06,xfuse(i,k),yfuse(i,k),zfuse(i,k),phifuse(i,k),thetafuse(i,k),psifuse(i,k),[0.5 0.5 0.5])
  %philw(i,k) = sin(t(i));
  %phirw(i,k) = -sin(t(i));
  CubeDrawShift(0.08,-0.4,0.01,xlw(i,k),ylw(i,k),zlw(i,k),philw(i,k),thetalw(i,k),psilw(i,k),[1 0 0])
  %CubeDrawShift(0.08,-0.4,0.01,0,0,0,pi/4,0,0,[1 0 0])
  %CubeDrawShiftR(0.08,-0.4,0.01,xrw(i,k),yrw(i,k),zrw(i,k),phirw(i,k),thetarw(i,k),psirw(i,k),[0 0 1])    
  CubeDrawShift(0.08,0.4,0.01,xrw(i,k),yrw(i,k),zrw(i,k),phirw(i,k),thetarw(i,k),psirw(i,k),[0 0 1])    
  title(t(i))
  axis equal
  target = [xfuse(i,k),yfuse(i,k),zfuse(i,k)];
  %target = [0,0,0];
  scale = 1.2;
  chat = [1 1 -0.3]*scale;
  set(gca,'CameraTarget',target,'CameraPosition',target+chat,'CameraView',5000,'CameraUpVector',[0,0,1],'Projection','perspective')
  drawnow
end
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
