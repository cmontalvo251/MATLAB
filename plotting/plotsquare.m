function plotsquare(x,y,z,phi,theta,psi,dx,dy)

%%Get vertex position in body frame
factor = 1;
counter = 1;
msize = [dx;dy];
rC_V_Body = dx.*[[-1;1;0],[1;1;0],[1;-1;0],[-1;-1;0]];

%%Get rotation matrix
R = R123(phi,theta,psi);

%%Get actual coordinates in inertial frame
rO_C_inertial = [x;y;z];
rO_V_inertial = rC_V_Body;
for ii = 1:4
  rO_V_inertial(:,ii) = rO_C_inertial + R*rC_V_Body(:,ii);
end

Xb = rO_V_inertial(1,:);
Yb = rO_V_inertial(2,:);
Zb = rO_V_inertial(3,:);

Face1 = patch(Xb,Yb,Zb,Zb,'facecolor',[.1 .8 .1],'facelighting','gouraud','edgecolor','none');
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
