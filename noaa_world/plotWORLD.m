purge

SAVE = 0;

%PLot
r = 73;
c = 144;
lat = linspace(90,-90,r);
lon = linspace(0,360,c);
llon = zeros(r,c);
llat = zeros(r,c);
zcam = 1;  
for idx = 1:length(lat)
  for jdx = 1:length(lon)
    llon(idx,jdx) = lon(jdx);
    llat(idx,jdx) = lat(idx);
  end
end

scale = 0.01;
add = 225.45;
Az = -58;
El = 40;
% [fig1,ax1] = plottool(1,'U',12,'Latitude(deg)','Longitude(deg)','Speed(m/s)',num2str(0),[Az,El]);
% [fig2,ax2] = plottool(1,'V',12,'Latitude(deg)','Longitude(deg)','Speed(m/s)',num2str(0),[Az,El]);
%[fig3,ax3] = plottool(1,'Sphere Plot',12,'','','','',[Az,El]);

sky = imread('world-map.jpg');
scalef = 1;
h1 = figure(1);
[X,Y,Z] = ellipsoid(0,0,0,1,1,1);
%Z(Z<0) = -.01;
X = X*scalef;
Y = Y*scalef;
Z = Z*scalef;
surf(X,Y,Z);
%h = findobj('Type','surface');
%set(h,'CData',flipdim(sky,1),'FaceColor','texturemap','edgecolor','none','FaceLighting','Gouraud','Clipping','off')
hold on
pause
num = '0000';
counter = 0;
if SAVE
  system('rm *.png');
end
for ii = 0:364
  
  time = ii;
  
  surf(X,Y,Z);
  h = findobj('Type','surface');
  set(h,'CData',flipdim(sky,1),'FaceColor','texturemap','edgecolor','none','FaceLighting','Gouraud','Clipping','off')
  
  if ii == 0
    for jj = 0:360
      xcam = 2*sin(jj*pi/180);
      ycam = 2*cos(jj*pi/180);
      cposition = [xcam,ycam,zcam];
      axis equal
      axis off
      set(gca,'CameraTarget',[0,0,0],'CameraPosition',cposition,'CameraView',90,'CameraUpVector',[0,0,1],'Projection','perspective')
      pause(0.01)
      if SAVE
  	%saveas(h1,['Movie_',num2str(num),'.png']);
      end
      counter = counter+1;
      cstr = num2str(counter);
      l = length(cstr);
      num(end-l+1:end) = cstr;
      M(counter) = getframe;
    end
    %%import
    eval(['ufile = ''Compiled_Data/U',num2str(time),'.txt'';'])
    eval(['vfile = ''Compiled_Data/V',num2str(time),'.txt'';'])
    udata = dlmread(ufile);
    vdata = dlmread(vfile);
    %%Convert
    udata = (udata.*scale)+add;
    vdata = (vdata.*scale)+add;
    [r,c] = size(udata);
    %%Plot Sphere 
    xx = 0.*llat;
    yy = xx;
    zz = xx;
    cc = xx;
    plotdata = sqrt(udata.^2+vdata.^2);
    if ii == 0
      minima = min(min(plotdata));
      maxima = max(max(plotdata));
      spread = maxima-minima;
    end
    rr = (plotdata-minima)./(spread);
    for idx = 1:length(lat)
      for jdx = 1:length(lon)
  	r = rr(idx,jdx)./4+1;
  	theta = pi/180*(-lat(idx)+90);
  	phi = pi/180*lon(jdx);
  	xx(idx,jdx) = r*sin(theta)*cos(phi);
  	yy(idx,jdx) = r*sin(theta)*sin(phi);
  	zz(idx,jdx) = r*cos(theta);
  	cc(idx,jdx) = plotdata(idx,jdx);
      end
    end
    mesh(xx,yy,zz,cc,'FaceColor','none');
    for jj = 0:360
      xcam = 2*sin(jj*pi/180);
      ycam = 2*cos(jj*pi/180);
      cposition = [xcam,ycam,zcam];
      axis equal
      axis off
      set(gca,'CameraTarget',[0,0,0],'CameraPosition',cposition,'CameraView',90,'CameraUpVector',[0,0,1],'Projection','perspective')
      pause(0.01)
      if SAVE
  	saveas(h1,['Movie_',num2str(num),'.png']);
      end
      counter = counter+1;
      cstr = num2str(counter);
      l = length(cstr);
      num(end-l+1:end) = cstr;
    end
  end
  if ii == 0
    num = '0722';
    counter = 722;
  end
  text(0,0,1.5,['Day = ',num2str(ii)])
  
  surf(X,Y,Z);
  h = findobj('Type','surface');
  set(h,'CData',flipdim(sky,1),'FaceColor','texturemap','edgecolor','none','FaceLighting','Gouraud','Clipping','off')
  
  %%import
  eval(['ufile = ''Compiled_Data/U',num2str(time),'.txt'';'])
  eval(['vfile = ''Compiled_Data/V',num2str(time),'.txt'';'])

  udata = dlmread(ufile);
  vdata = dlmread(vfile);

  %%Convert
  udata = (udata.*scale)+add;
  vdata = (vdata.*scale)+add;
  [r,c] = size(udata);

  %%Plot Sphere 
  xx = 0.*llat;
  yy = xx;
  zz = xx;
  cc = xx;
  plotdata = sqrt(udata.^2+vdata.^2);
  if ii == 0
    minima = min(min(plotdata));
    maxima = max(max(plotdata));
    spread = maxima-minima;
  end
  rr = (plotdata-minima)./(spread);
  for idx = 1:length(lat)
    for jdx = 1:length(lon)
      r = rr(idx,jdx)./4+1;
      theta = pi/180*(-lat(idx)+90);
      phi = pi/180*lon(jdx);
      xx(idx,jdx) = r*sin(theta)*cos(phi);
      yy(idx,jdx) = r*sin(theta)*sin(phi);
      zz(idx,jdx) = r*cos(theta);
      cc(idx,jdx) = plotdata(idx,jdx);
    end
  end
  mesh(xx,yy,zz,cc,'FaceColor','none');
  
  xcam = 2*sin(ii*pi/180);
  ycam = 2*cos(ii*pi/180);
  cposition = [xcam,ycam,zcam];
  set(gca,'CameraTarget',[0,0,0],'CameraPosition',cposition,'CameraView',90,'CameraUpVector',[0,0,1],'Projection','perspective')
  axis equal
  axis off
  
  pause(0.01)
  
  if SAVE
    if counter >= 1039
      saveas(h1,['Movie_',num2str(num),'.png']);
    end
  end
  counter = counter+1;
  cstr = num2str(counter);
  l = length(cstr);
  num(end-l+1:end) = cstr;
  
  cla;

end
