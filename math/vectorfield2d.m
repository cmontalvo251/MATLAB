function [pathx pathy] = vectorfield2d(gradx,grady,xvec,yvec,xstart,spacestep)
%function [pathx pathy] = vectorfield2d(gradx,grady,xstart,spacestep)
%%this will compute a path to the local minima of a gradient field

global mark1 mark2

[m,n] = size(gradx);

mark1 = [1 2];
mark2 = [1 2];
flag = 0;
loop = 1;
STEPLIMIT = 1000;
pathx = zeros(STEPLIMIT,1);
pathy = pathx;
x = xstart;
%%Save States
pathx(1) = xstart(1);
pathy(1) = xstart(2);

%RK4 in space
while loop < STEPLIMIT

  loop = loop + 1;
  
  %%Calculate the first slope
  [k1,flag] = derivs(x,gradx,grady,xvec,yvec);
  normk = norm(k1);

  %%State update
  if normk > 0
    xm = x + k1.*spacestep/(2*normk);
  else
    xm = x;
  end
  
  %%Calculate the second slope
  [k2,flag] = derivs(xm,gradx,grady,xvec,yvec);

  %%State update
  if normk > 0
    xm = x + k2.*spacestep/(2*normk);
  else
    xm = x;
  end
  
  %%Calculate the third slope
  [k3,flag] = derivs(xm,gradx,grady,xvec,yvec);
  
  %%State update
  if normk > 0
    xe = x + k3.*spacestep/(normk);
  else
    xe = x;
  end
  
  %%Calculate the fourth slope
  [k4,flag] = derivs(xe,gradx,grady,xvec,yvec);
  
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
  %%Check for local min
end
if loop < STEPLIMIT
  pathx = pathx(1:loop-1);
  pathy = pathy(1:loop-1);
end

disp(['Path Iterations = ',num2str(loop)])

function [ds,flag] = derivs(x,gradx,grady,xvec,yvec)
global mark1 mark2

flag = 0;
ds = [0;0];

%%Check for bounds
if x(1) >= xvec(end) || x(1) <= xvec(1) || x(2) >= yvec(end) || x(2) <= yvec(1)
  flag = 1;
end

if flag == 0;
  xstar = x(1);
  ystar = x(2);

  dx = interpsave2(xvec,yvec,gradx,xstar,ystar);
  dy = interpsave2(xvec,yvec,grady,xstar,ystar);
  ds = [dx;dy];
end



% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
