function zinterp = interppatch(centroidsxy,x,y,z,xidx,yidx)

[r,numpatches] = size(x);

dist = abs(centroidsxy'-ones(numpatches,1)*[xidx,yidx]);
distnorm = dist(:,1) + dist(:,2);
loc = find(distnorm == min(distnorm));
xAs = x(:,loc);
yAs = y(:,loc);
zAs = z(:,loc);

%patch(xAs,yAs,zAs,zAs,'facecolor','none')

rA = [xAs(1);yAs(1);zAs(1)];
rB = [xAs(2);yAs(2);zAs(2)];
rC = [xAs(3);yAs(3);zAs(3)];
v1hat = (rC-rA)/norm(rC-rA);
v2hat = (rC-rB)/norm(rC-rB);
V = [v1hat,v2hat];
Vpart = V(1:2,:);
sig12 = Vpart\([xidx;yidx]-rA(1:2));

%%%Check
zinterp = sig12(1)*v1hat(3) + sig12(2)*v2hat(3) + rA(3);

%plot3(xidx,yidx,zinterp,'b*','MarkerSize',10)
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
