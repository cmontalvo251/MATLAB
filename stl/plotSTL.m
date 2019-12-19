purge


FINDPTS = 0;
ROTATE1 = 1;
ROTATE2 = 1;
CONTOUR = 1;
SAVE = 1;
REAR = 1;

%%Get properties of wheels
%load ~/Other/Wheels/Nov_8/MAT_11_8/inheat_front.mat
load 'c:/Documents and Settings/carlos/My Documents/Other/MAT_11_8/venom_rear.mat'
[r,c] = size(x);
%%venom rear
% filename = 'venom_rear.SCR';
% s = round(c/3);
% e = c;
% xP = [1.454 2.697 1.572];
% yP = [-0.4252 -1.548 -2.997];
% zP = [2.1 1.532 2.035];
% phi = 135*pi/180;
% xlimit = 0.5;
% ylimitL = -2.1;
% ylimitR = -2.09;
%venom_front
% filename = 'venom_front.SCR';
% s = 100000;
% e = c;
% xP = [1.443 2.573 1.363];
% yP = [-3.002 -1.967 -0.3813];
% zP = [1.837 1.245 1.884];
% phi = 135*pi/180;
% xlimit = 0.8;
% ylimitL = 1.68;
% ylimitR = 1.7;
%%Centrax rear
% filename = 'centrax_rear.SCR';
% s = 66000;
% e = c;
% xP = [1.082 2.704 1.117];
% yP = [-3.134 -2.011 -0.3661];
% zP = [2.313 1.734 2.401];
% phi = 135*pi/180;
% xlimit = 1.2;
% ylimitL = 1.45;
% ylimitR = 1.5;
%%centrax_front
% filename = 'centrax_front.SCR';
% s = 70000;
% e = c;
% xP = [1.425 2.773 1.405];
% yP = [-0.3633 -1.942 -3.093];
% zP = [2.37 1.868 2.282];
% phi = 90*pi/180;
% xlimit = 2;
% ylimitL = -0.6;
% ylimitR = -0.55;
%%bigzig rear
% filename = 'bigzig_rear.SCR';
% s = 1;
% e = 105000;
% xP = [0.2364 1.192 1.105];
% yP = [-1.87 -3.06 -0.5645];
% zP = [2.575 2.268 2.377];
% phi = pi;
% xlimit = 0.5;
% ylimitL = -1.7;
% ylimitR = -1.68;
% %%bigzig front
% filename = 'bigzig_font.SCR';
% s = 1;
% e = 62000;
% xP = [-0.02456 0.9202 0.8646];
% yP = [-1.722 -2.87 -0.3263];
% zP = [2.368 2.221 2.23];
% phi = -90*pi/180;
% xlimit = -1.5;
% ylimitL = -0.33;
% ylimitR = -0.32;
%inheat front
% filename = 'inheat_front.SCR';
% s = 100000;
% e = c;
% xP = [1.178 2.84 1.296];
% yP = [-3.052 -1.716 -0.2176];
% zP = [2.538 2.219 2.545];
% phi = 135*pi/180;
% xlimit = 1.2;
% ylimitL = 1.495;  %%1.495
% ylimitR = 1.5;    %%1.5
%%inheat rear
% filename = 'inheat_rear.SCR';
% s = 1;
% e = c;
% xP = [1.888 0.8481 2.681];
% yP = [-2.948 -1.009 -0.6721];
% zP = [1.858 2.477 1.434];
% phi = 0;
% xlimit = 0;
% ylimitL = -1.7;
% ylimitR = -1.6;

plottool(1,'Wheels',12,'x','y','z','wheel',[162 20])
if FINDPTS
  for ii = 1:1000:c
    ii
    xplot = x(1,s:ii);
    yplot = y(1,s:ii);
    zplot = z(1,s:ii);
    hold off
    plot3(xplot,yplot,zplot,'b.')
    drawnow
  end
else
  x = x(1,s:e);
  y = y(1,s:e);
  z= z(1,s:e);
  plot3(x,y,z,'b.')
end

if ROTATE1
  hold on
  %%Get 3 Coordinates of Plane
  patch(xP,yP,zP,'r-','LineWidth',2)
  %%Compute Normal Vector based on 3 coordinates
  v1 = [xP(2)-xP(1) yP(2)-yP(1) zP(2)-zP(1)]';
  v2 = [xP(3)-xP(1) yP(3)-yP(1) zP(3)-zP(1)]';
  %let nx = 1
  nx = 1;
  A = [v1(2) v1(3);v2(2) v2(3)];
  b = -nx*[v1(1);v2(1)];
  xest = inv(A'*A)*A'*b;
  ny = xest(1);
  nz = xest(2);
  N = [nx ny nz]';
  %%Normalize N
  N = N./norm(N);
  %%plot normal vector
  f = 0.2;
  plot3([xP(1) xP(1)+f*N(1)],[yP(1) yP(1)+f*N(2)],[zP(1) zP(1)+f*N(3)],'k-','LineWidth',2)
  %%Generate R matrix
  u1 = v1./norm(v1);
  v2prime = v2 - (u1'*v2)*u1;
  u2 = v2prime./norm(v2prime);
  R(1,:) = N';
  R(2,:) = u1';
  R(3,:) = u2';
  %%Rotate Image coordinates
  xR = x;
  yR = y;
  zR = z;
  for ii = 1:length(x)
    original = [x(ii);y(ii);z(ii)];
    rotated = R*original;
    xR(ii) = rotated(1);
    yR(ii) = rotated(2);
    zR(ii) = rotated(3);
  end
  xI = zR;
  yI = yR;
  zI = xR;
  plottool(1,'Rotated',12,'x','y','z')
  plot3(xI,yI,zI,'b*')
  view(0,0)
end
if ROTATE2
  %%Rotate by phi
  R = [cos(phi) -sin(phi) 0;sin(phi) cos(phi) 0;0 0 1];
  for ii = 1:length(xI)
    original = [xI(ii);yI(ii);zI(ii)];
    rotated = R'*original;
    xR(ii) = rotated(1);
    yR(ii) = rotated(2);
    zR(ii) = rotated(3);
  end
  xI = xR;
  yI = yR;
  zI = zR;
  plottool(1,'Rotated',12,'x','y','z')
  plot3(xI,yI,zI,'b*')
  view(0,90)
end
if CONTOUR
  %%Now we need to figure out a way to get a good contour
  xcontour = -100.*ones(length(xI),1);
  ycontour = xcontour;
  zcontour = ycontour;
  for ii = 1:length(xI)
    if xI(ii) > xlimit && (yI(ii) > ylimitL && yI(ii) < ylimitR)
      xcontour(ii) = xI(ii);
      ycontour(ii) = yI(ii);
      zcontour(ii) = zI(ii);
    end
  end
  xcontour(xcontour==-100)=[];
  ycontour(ycontour==-100)=[];
  zcontour(zcontour==-100)=[];
  %%Move xcontour
  xcontour = xcontour - min(xcontour);
  ycontour = 0.*ycontour;
  zcontour = zcontour - min(zcontour);
  %Now reorient to x and y
  xfinal = xcontour;
  if REAR
    yfinal = -zcontour;
  else
    yfinal = zcontour;
  end
  %%Sort it by distance from the origin
  r = sqrt(xfinal.^2 + yfinal.^2);
  [rsort,index] = sort(r);
  xfinal = xfinal(index);
  yfinal = yfinal(index);
  %%Ok plot this new contour
  plottool(1,'Contour',12)
  plot(xfinal,yfinal,'b-')
end
if SAVE
  dlmwrite(filename,[xfinal' yfinal'])
end



