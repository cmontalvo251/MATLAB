function plotcube(dx,dy,dz,x,y,z,phi,theta,psi,ctype)
%%plots a cube with dimensions dx,dy,dz
%%centered at x,y,z and 3-2-1 orientation
%%phi,theta,psi

%%setup colormap
if nargin > 9
  cmap = colormap(ctype);
  [r,col] = size(cmap);
  %%make length 6
  cmap = cmap(1:floor(r/6):end,:);
  cmap = cmap(3,:);
else
  cmap = 'none';
end

%%get side locations
zbottom = z-dz/2;
ztop = z+dz/2;
xleft = x-dx/2;
xright = x+dx/2;
yback = y-dy/2;
yfront = y+dy/2;

%%plot surfaces 1-6
dummy = [1 1 1 1];
%%bottom plate
xb = [xleft xleft xright xright];
yb = [yback yfront yfront yback];
zb = [zbottom zbottom zbottom zbottom];
patch(xb,yb,zb,dummy,'facecolor',cmap,'facelighting','gouraud');

%%top plate
zb = [ztop ztop ztop ztop];
patch(xb,yb,zb,dummy,'facecolor',cmap,'facelighting','gouraud');

%%left plate
xb = [xleft xleft xleft xleft];
yb = [yfront yfront yback yback];
zb = [zbottom ztop ztop zbottom];
patch(xb,yb,zb,dummy,'facecolor',cmap,'facelighting','gouraud');

%right plate
xb = [xright xright xright xright];
patch(xb,yb,zb,dummy,'facecolor',cmap,'facelighting','gouraud');

%%front plate
xb = [xleft xleft xright xright];
yb = [yfront yfront yfront yfront];
zb = [zbottom ztop ztop zbottom];
patch(xb,yb,zb,dummy,'facecolor',cmap,'facelighting','gouraud');

%%rear plate
yb = [yback yback yback yback];
patch(xb,yb,zb,dummy,'facecolor',cmap,'facelighting','gouraud');




% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
