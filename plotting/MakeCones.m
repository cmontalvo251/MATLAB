function [xx,yy,zz] = MakeCones(x,y,z,rotaxis,revs)

% rotaxis = 'y';
% axis1 = 'y';
% axis2 = 'x';
% axis3 = 'z';
% v1 = 0:0.01:1;
% v2 = exp(v1);
% v3 = sin(10.*v1)+1;
N = length(x);
% revs = 100;
% figure()
% plot3(x,y,0.*z,'b-','LineWidth',4)
% hold on
% plot3(0.*x,y,z,'r-','LineWidth',4)

%%%%Generate xx,yy,zz

xx = zeros(N,revs);
yy = xx;
zz = xx;
theta = linspace(0,2*pi,revs);

for ii = 1:N
  for jj = 1:revs
    switch rotaxis
     case 'x'
      xx(ii,jj) = x(ii);
      yy(ii,jj) = y(ii)*cos(theta(jj));
      zz(ii,jj) = z(ii)*sin(theta(jj));
     case 'y'
      %%interpolate x and z
      xx(ii,jj) = x(ii)*cos(theta(jj));
      yy(ii,jj) = y(ii);
      zz(ii,jj) = z(ii)*sin(theta(jj));
     case 'z'
      xx(ii,jj) = x(ii)*sin(theta(jj));
      yy(ii,jj) = y(ii)*cos(theta(jj));
      zz(ii,jj) = z(ii);
    end
  end
end

% hold on

% mesh(xx,yy,zz)
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
