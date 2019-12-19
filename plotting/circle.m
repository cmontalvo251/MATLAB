function circle(x,y,r,c,lc)
%function circle(x,y,r,c)
%this will plot a circle with center x,y and radius r
%%use ball.m to plot a sphere

if nargin <= 3
  c = 'none';
end
if nargin <= 4
  lc = 'k';
end
  
rectangle('Position',[x-r,y-r,2*r,2*r],'Curvature',[1,1],'facecolor',c)
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
