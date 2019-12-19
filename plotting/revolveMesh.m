function [xx,yy,zz] = revolveMesh(v1,axis1,v2,axis2,rotaxis,revs,rot_angle)

% rotaxis = 'z';
% axis1 = 'x';
% axis2 = 'y';
% v1 = 0:0.01:1;
% v2 = v1;
N = length(v1);
% revs = 10;

switch axis1
 case 'x'
  x = v1;
 case 'y'
  y = v1;
 case 'z'
  z = v1;
end

switch axis2
 case 'x'
  x = v2;
 case 'y'
  y = v2;
 case 'z'
  z = v2;
end

if ~exist('z','var')
  z = zeros(length(x),1);
elseif ~exist('x','var')
  x = zeros(length(y),1);
elseif ~exist('y','var')
  y = zeros(length(x),1);
end

%plot3(x,y,z)

%%%%Generate xx,yy,zz

xx = zeros(N,revs);
yy = xx;
zz = xx;
theta = linspace(0,rot_angle,revs);

for ii = 1:N
  for jj = 1:revs
    switch rotaxis
     case 'x'
      xx(ii,jj) = x(ii);
      d = norm([y(ii) z(ii)]);
      yy(ii,jj) = d*cos(theta(jj));
      zz(ii,jj) = d*sin(theta(jj));
     case 'y'
      d = norm([x(ii) z(ii)]);
      xx(ii,jj) = d*cos(theta(jj));
      yy(ii,jj) = y(ii);
      zz(ii,jj) = d*sin(theta(jj));
     case 'z'
      d = norm([x(ii) y(ii)]);
      xx(ii,jj) = d*sin(theta(jj));
      yy(ii,jj) = d*cos(theta(jj));
      zz(ii,jj) = z(ii);
    end
  end
end

%hold on

%mesh(xx,yy,zz)
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
