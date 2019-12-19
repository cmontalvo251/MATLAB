function [pathx pathy] = streammagnet(xstart,spacestep,magnet,plane)
%function [pathx pathy] = vectorfieldexplicit(gradx,grady,xstart,spacestep)
%%this will compute a path to the local minima of a gradient field

%boxstuff 
a = magnet(1);
b = magnet(2);
c = magnet(3);
dx = 2*a;
dy = 2*b;
dz = 2*c;
xc = magnet(4);
yc = magnet(5);
zc = magnet(6);
Br = magnet(7);
mark1 = [1 2];
mark2 = [1 2];
flag = 0;
loop = 1;
x = xstart;
%%Save States
pathx = [1];
pathy = [1];
pathx(1) = xstart(1);
pathy(1) = xstart(2);

%RK4 in space
while flag == 0

  loop = loop + 1;
  
  %%Calculate the first slope
  [k1] = magfield(plane,x(1),x(2),a,b,c,xc,yc,zc,Br);
  k1 = k1(2:3);
  normk = norm(k1);

  %%State update
  if normk > 0
    xm = x + k1.*spacestep/(2*normk);
  else
    xm = x;
  end
  
  %%Calculate the second slope
  [k2] = magfield(plane,xm(1),xm(2),a,b,c,xc,yc,zc,Br);
  k2 = k2(2:3);
  
  %%State update
  if normk > 0
    xm = x + k2.*spacestep/(2*normk);
  else
    xm = x;
  end
  
  %%Calculate the third slope
  [k3] = magfield(plane,xm(1),xm(2),a,b,c,xc,yc,zc,Br);
  k3 = k3(2:3);
  
  %%State update
  if normk > 0
    xe = x + k3.*spacestep/(normk);
  else
    xe = x;
  end
  
  %%Calculate the fourth slope
  [k4] = magfield(plane,xm(1),xm(2),a,b,c,xc,yc,zc,Br);
  k4 = k4(2:3);
  
  %%Take a weighted average of the slopes
  dpath = (k1 + 2*k2 + 2*k3 + k4)/6;
  
  normk = norm(dpath);
  
  %%State update
  if normk > 0
    x = x + dpath.*spacestep/(normk);
  else
    flag = 1;
  end
  
  %%Save States
  pathx(loop) = x(1);
  pathy(loop) = x(2);
  
  %%Check for magnetic field return
  leftside = yc - b;
  rightside = yc + b;
  top = zc + c;
  bottom = zc - c;
  if x(1) >= leftside && x(1) <= rightside
    if x(2) <= top && x(2) >= bottom
      flag = 1;
    end
  end

end


%disp(['Path Iterations = ',num2str(loop)])


% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
