function DrawFrisbee(dx,dy,dz,xc,yc,zc,phi,theta,psi)

[xb,yb,zb] = sphere();
Xb = xb;
Yb = yb;
Zb = zb;

T = R123(phi,theta,psi);

[n,m] = size(xb);

rc = [xc;yc;zc];

for ii = 1:n;
  for jj = 1:m
    xs = xb(ii,jj)*dx;
    ys = yb(ii,jj)*dy;
    zs = zb(ii,jj)*dz;

    xyz = [xs,ys,zs]';

    xyz_trans = rc + T*xyz;

    Xb(ii,jj) = xyz_trans(1);
    Yb(ii,jj) = xyz_trans(2);
    Zb(ii,jj) = xyz_trans(3);
  end
end

mesh(Xb,Yb,Zb);
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
