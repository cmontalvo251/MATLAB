close all

global STLREAD xyzf xyzL xyzR xyzp

OBJECT = 0; %0=plane,1=cubes

if ts ~= timestep
  %%Find occurence of first inf or -inf
  [r,c] = size(xout);
  locnan = c;
  for ii = 1:r
    loc1 = find(isnan(xout(r,:)),1);
    if loc1 < locnan
      locnan = loc1;
    end
  end
  col = locnan-1;
  xnew = xout(:,1:locnan-1);
  tnew = tout(1:locnan-1);
  new_t = tnew(1):ts:tnew(end);
  err = 1;
  while err
    try
      disp('trying..')
      new_x = interp1(tnew(1:col),xnew(:,1:col)',new_t);
      err = 0;
    catch me
      err = 1;
      disp('error found')
      disp(me.message)
      col = col - 1
    end
  end
  disp('Interpolation Succeeded')
  new_x = new_x';
else
  new_t = tout;
  new_x = xout;
end

t = new_t;

x = [];y=[];z=[];
for ii = 1:num_ac
  s = (ii-1)*(NSTATES)+1;
  x = [x;new_x(s,:)];
  y = [y;new_x(s+1,:)];
  z = [z;new_x(s+2,:)];
end
del = 0.5;
if num_ac == 1
  xmin = min(x)-del;
  xmax = max(x)+del;
  ymin = min(y)-del;
  ymax = max(y)+del;
  zmin = min(z)-del;
  zmax = max(z)+del;
else
  xmin = min(min(x))-del;
  xmax = max(max(x))+del;
  ymin = min(min(y))-del;
  ymax = max(max(y))+del;
  zmin = min(min(z))-del;
  zmax = max(max(z))+del;
end
color = [.1 .1 .1];
color1 = [.8 .1 .1];
% import Solidworks STL files
if ~exist('STLREAD','var')
  STLREAD = 0;
end
if isempty(STLREAD) || STLREAD == 0
  [xf,yf,zf]=stlread('Fuselage.STL');
  [xL,yL,zL]=stlread('LWing.STL');
  [xR,yR,zR]=stlread('RWing.STL');
  [xp,yp,zp]=stlread('Prop.STL');
  xyzf = [xf;yf;zf];
  xyzL = [xL;yL;zL];
  xyzR = [xR;yR;zR];
  xyzp = [xp;yp;zp];
  STLREAD = 1;
end

%%Create Colormap
dg = [0 150 0]./255;
cht = [127 255 0]./255;
rvec = dg(1):cht(1)';
gvec = dg(2):cht(2)';
bvec = dg(3):cht(3)';
h1 = plottool(1,'Plane',18,'x(m)','y(m)','z(m)');
pause
tstart = 0;
istart = find(t>tstart,1);
skip = 70;
wingspan = [10*2.04;2.04;2.04];
for i = istart:skip:length(t)
  %hold off
  %cla;
  FIXED = 0;
  if OBJECT == 0
    for ii = 1:num_ac %%%%%%%%%%%%%%%%%%
      num = (ii-1)*NSTATES+1;
      state = new_x(num:num+5,i);
      %draw_plane(new_x(num:num+11,i),'b',wingspan)
      state(3) = 0;
      draw_plane_fancy(state,xyzf,xyzL,xyzR,xyzp,wingspan,t(i),ii)
      %draw_plus_sign(state,2.04);
    end
  end
  hold on
  %reverse(['y','z'])
  xlabel('X(m)')
  ylabel('Y(m)')
  %zlabel('z')
  %axis equal
  axis on
  grid on
  view(0,90)
  drawnow
end
%ylim([-10 10])
%axis([0 1500 -15 15 -1 1])
%system('makemovie 20 /home/carlos/Desktop/Lattice.avi jpg')
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
