function ball(xc,yc,zc,r)
%%%ball(xc,yc,zc,r)
%%%plots a sphere at xc,yc,zc
%%%r the radius

[x,y,z] = sphere(20);
hold on
surf(x.*r+xc,y.*r+yc,z.*r+zc,'LineStyle','none','FaceColor',[1 1 1])
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
