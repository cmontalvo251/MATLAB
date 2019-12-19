function plot6DOF(filename,flag,vec,units,filename2,filename3,filename4)
%function plot6DOF(filename,flag,vec,units,filename2)
%%this will and plot all the states of a regular 6dof trajectory

disp('Loading First File')
out = dlmread(filename);

tout = out(:,1);
toutN = {tout};
Names = {filename};
xout = out(:,2:end);
%%Compute impact point
x = xout(:,1);
y = xout(:,2);
z = xout(:,3);
loc = find(z>0,1);
if ~isempty(loc) && (loc > 1)
  z2 = z(loc);
  z1 = z(loc-1);
  x2 = x(loc);
  x1 = x(loc-1);
  y2 = y(loc);
  y1 = y(loc-1);
  t1 = tout(loc-1);
  t2 = tout(loc);
  tground = t1 + (-z1)*(t2-t1)/(z2-z1)
  zground = z1 + (z2-z1)*(tground-t1)/(t2-t1)
  xground = x1 + (x2-x1)*(tground-t1)/(t2-t1)
  yground = y1 + (y2-y1)*(tground-t1)/(t2-t1)
end
[r,c] = size(xout);

if nargin >= 5
  disp('Loading Second File')
  out2 = dlmread(filename2);
  tout2 = out2(:,1);
  xout2 = out2(:,2:end);
  toutN = [toutN {tout2}];
  xoutN = {xout2};
  Names = [Names filename2];
  x = xout2(:,1);
  y = xout2(:,2);
  z = xout2(:,3);
  loc = find(z>0,1);
  if ~isempty(loc)
    z2 = z(loc);
    z1 = z(loc-1);
    x2 = x(loc);
    x1 = x(loc-1);
    y2 = y(loc);
    y1 = y(loc-1);
    t1 = tout2(loc-1);
    t2 = tout2(loc);
    tground = t1 + (-z1)*(t2-t1)/(z2-z1)
    zground2 = z1 + (z2-z1)*(tground-t1)/(t2-t1)
    xground2 = x1 + (x2-x1)*(tground-t1)/(t2-t1)
    yground2 = y1 + (y2-y1)*(tground-t1)/(t2-t1)
  end
end

if nargin >= 6
  out3 = dlmread(filename3);
  tout3 = out3(:,1);
  xout3 = out3(:,2:end);
  toutN = [toutN tout3];
  xoutN = [xoutN xout3];
  Names = [Names filename3];
end

if nargin >= 7
  out4 = dlmread(filename4);
  tout4 = out4(:,1);
  xout4 = out4(:,2:end);
  toutN = [toutN tout4];
  xoutN = [xoutN xout4];
  Names = [Names filename4];
end

if nargin <= 2
  vec = 1:c;
end

if nargin <= 1
  flag = '';
end

%Names = {'Ballistic','Controlled'};
Names = {'Ballistic Multi-Body','Ballistic Rigid Body', 'Controlled Multi-Body','Controlled Rigid Body'};

if exist('xout2','var')
  if strcmp(flag,'Quat')
    Plot6Quat(vec,{toutN},xout,1,'m',xoutN,Names)
  else
    Plot6(vec,{tout},xout,1,'m',tout,xoutN,0)
  end
else
  if strcmp(flag,'Quat')
    Plot6Quat(vec,{tout},xout,1)
  else
    Plot6(vec,{tout},xout,1)
  end
end


% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
