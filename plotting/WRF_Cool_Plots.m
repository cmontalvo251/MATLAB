%%This code will plot the terrain and spatial cross sections as
%well as plot u,v, and w at a specific location as a function of time
clear
%clc

%%Front End
dataloc = '~/Documents/WRF_Wind_Data/Data25dx_HF_0/';
UVWfrontend

cmap = colormap;
close all

%v
% 2.0489    4.0993
%1.8727    3.9343
%1.8272    3.7905

%w
%0
%-1.5167    2.6600
%-1.7979    2.2902
%-0.7627    0.6148

%.3
%-1.4730    2.7054
%-1.5291    2.1864
%-0.6900    0.6202

%%ADMIN FLAGS

TERRAIN = 0;
PLOT1 = 0; %%plot single points as a function of time
PLOT2 = 1; %%plot cross sections at a given instant in time
PLOTARROWS = 0; %plot arrows

%%Import Terrain Height
height = dlmread([dataloc,'THeight.txt']);

%%Create X and Y coord
[xx,yy] = meshgrid(xcoord,ycoord);
[xx,zz] = meshgrid(xcoord,zcoord);
meshview = [-27,30];

%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%Plot Single points as a function of time%%%%%%%%%%%%%%%%%

if PLOT1
  xstar = 0;
  ystar = 0;
  zstar = 200;
  tmax = 60;
  tlength = find(tcoord > tmax,1)-1;
  uvw = zeros(3,tlength);
  for ii = 1:tlength
    uvw(:,ii) = uvwout(xstar,ystar,zstar,tcoord(ii),dataloc,1);
    disp(['Time = ',num2str(tcoord(ii))])
  end
  titlename = ['x = ',num2str(xstar),' y = ',num2str(ystar),' z =',num2str(zstar),' m'];
  subtool(3,1,tcoord(1:tlength),uvw,'UVW',{'U m/s','V m/s','W m/s'},'Time(sec)',2,'bo-',titlename)
end

%%%%%%%%%%%Plot Cross Sections at a given instant in time%%%%%%

if PLOT2
  %%pick xz, yz, or xy cross section
  plane = 'yz';
  %loc = [30 90 150]; %%%This is for W
  loc = [-250 0 250]; %%%This is for U and V
  location = loc(1); %%pick the plane then pick the independent variable for location
  time = 0;      %%finally pick the time you'd like to look at
  Umap = zeros(maxDim,maxDim);
  Vmap = Umap;
  Wmap = Umap;
  for ii = 1:maxDim
    for jj = 1:maxDim
      if strcmp(plane,'xy')
          uvw = uvwout(xx(ii,jj),yy(ii,jj),location,time,dataloc,1);
      elseif strcmp(plane,'xz')
          uvw = uvwout(xx(ii,jj),location,zz(ii,jj),time,dataloc,1);
      elseif strcmp(plane,'yz')
          yytemp = yy';
          uvw = uvwout(location,yytemp(ii,jj),zz(ii,jj),time,dataloc,1);
      end
      Umap(ii,jj) = uvw(1);
      Vmap(ii,jj) = uvw(2);
      Wmap(ii,jj) = uvw(3);
    end
  end

  location = loc(2); %%pick the plane then pick the independent variable for location

  Umap2 = zeros(maxDim,maxDim);
  Vmap2 = Umap2;
  Wmap2 = Umap2;
  for ii = 1:maxDim
    for jj = 1:maxDim
      if strcmp(plane,'xy')
          uvw = uvwout(xx(ii,jj),yy(ii,jj),location,time,dataloc,1);
      elseif strcmp(plane,'xz')
          uvw = uvwout(xx(ii,jj),location,zz(ii,jj),time,dataloc,1);
      elseif strcmp(plane,'yz')
          yytemp = yy';
          uvw = uvwout(location,yytemp(ii,jj),zz(ii,jj),time,dataloc,1);
      end
      Umap2(ii,jj) = uvw(1);
      Vmap2(ii,jj) = uvw(2);
      Wmap2(ii,jj) = uvw(3);
    end
  end

  location = loc(3); %%pick the plane then pick the independent variable for location

  Umap3 = zeros(maxDim,maxDim);
  Vmap3 = Umap3;
  Wmap3 = Umap3;
  for ii = 1:maxDim
    for jj = 1:maxDim
      if strcmp(plane,'xy')
          uvw = uvwout(xx(ii,jj),yy(ii,jj),location,time,dataloc,1);
      elseif strcmp(plane,'xz')
          uvw = uvwout(xx(ii,jj),location,zz(ii,jj),time,dataloc,1);
      elseif strcmp(plane,'yz')
          yytemp = yy';
          uvw = uvwout(location,yytemp(ii,jj),zz(ii,jj),time,dataloc,1);
      end
      Umap3(ii,jj) = uvw(1);
      Vmap3(ii,jj) = uvw(2);
      Wmap3(ii,jj) = uvw(3);
    end
  end
  if strcmp(plane,'xy')
      clim = [min(min([Wmap Wmap2 Wmap3])) max(max([Wmap Wmap2 Wmap3]))];
      vc = linspace(clim(1),clim(2),64)';
      %plottool(1,'mesh',12,'x (m)','y (m)','u(m/s)',['XY Plane @ z = ',num2str(location),' and t = ',num2str(time)],meshview)
      %     mesh(xx,yy,Umap)
      %     plottool(1,'mesh',12,'x (m)','y (m)','v(m/s)',['XY Plane @ z = ',num2str(location),' and t = ',num2str(time)],meshview)
      %     mesh(xx,yy,Vmap)
      %      plottool(1,'mesh',12,'x (m)','y (m)','w(m/s)',['XY Plane @ z = ',num2str(location),' and t = ',num2str(time)],meshview)
      % %     figure
     %mesh(xx,yy,Wmap)
     plottool(1,'mesh',14,'x (m)','y (m)','z (m)','Vertical Velocity at Multiple Altitudes')
     set(gca,'Clim',clim)
     colorbar
     % %     set(gca,'XTickLabel','','YTickLabel','','XColor',[1 1 1],'YColor',[1 1 1])
     %         daspect([166.7 166.7 10])
     %     view([-35 10]);
     %     zlim([-2 3]);
     %     set(gca,'Clim',[-1.8 2.7])
     %     zlabel('w(m/s)')
     hold on
    
     vs = 90/40;
    for i=2:size(xx,2)
        for j=2:size(xx,1)
            c = interp1(vc,cmap,mean(Wmap(j-1:j,i)));
            patch([xx([j-1 j],i-1);xx([j j-1],i)],[yy([j-1 j],i-1);yy([j j-1],i)],[Wmap([j-1 j],i-1);Wmap([j j-1],i)]*vs+loc(1),[1 1 1],'EdgeColor',c)
        end
    end
    for i=2:size(xx,2)
        for j=2:size(xx,1)
            c = interp1(vc,cmap,mean(Wmap2(j-1:j,i)));
            patch([xx([j-1 j],i-1);xx([j j-1],i)],[yy([j-1 j],i-1);yy([j j-1],i)],[Wmap2([j-1 j],i-1);Wmap2([j j-1],i)]*vs+loc(2)-.5*vs,[1 1 1],'EdgeColor',c)
        end
    end
    for i=2:size(xx,2)
        for j=2:size(xx,1)
            c = interp1(vc,cmap,mean(Wmap3(j-1:j,i)));
            patch([xx([j-1 j],i-1);xx([j j-1],i)],[yy([j-1 j],i-1);yy([j j-1],i)],[Wmap3([j-1 j],i-1);Wmap3([j j-1],i)]*vs+loc(3)-.5*vs,[1 1 1],'EdgeColor',c)
        end
    end
    daspect([5 5 1])
    view([125 15])
%    ylim([-350 350])
    set(gca,'Ztick',[30 90 150])
    hold off
    grid on
    %xlabel('x(m)')
    %ylabel('y(m)')
    %zlabel('z(m)')
  elseif strcmp(plane,'xz')
      plottool(1,'mesh',12,'x (m)','y (m)','z (m)','Side Velocity at Multiple Y Locations');
      clim = [min(min([Vmap Vmap2 Vmap3])) max(max([Vmap Vmap2 Vmap3]))];
      vc = linspace(clim(1),clim(2),64)';
      mesh(xx,zz,Vmap)
      set(gca,'Clim',clim)
      colorbar('Location','EastOutside')
      cla;
    hold on
    vs = 50;
    for i=2:size(xx,2)
        for j=2:size(xx,1)
            c = interp1(vc,cmap,mean(Vmap(j-1:j,i)));
            patch([xx([j-1 j],i-1);xx([j j-1],i)],[Vmap([j-1 j],i-1);Vmap([j j-1],i)]*vs-250-3*vs,[zz([j-1 j],i-1);zz([j j-1],i)],[1 1 1],'EdgeColor',c)
        end
    end
    for i=2:size(xx,2)
        for j=2:size(xx,1)
            c = interp1(vc,cmap,mean(Vmap2(j-1:j,i)));
            patch([xx([j-1 j],i-1);xx([j j-1],i)],[Vmap2([j-1 j],i-1);Vmap2([j j-1],i)]*vs-3*vs,[zz([j-1 j],i-1);zz([j j-1],i)],[1 1 1],'EdgeColor',c)
        end
    end
    for i=2:size(xx,2)
        for j=2:size(xx,1)
            c = interp1(vc,cmap,mean(Vmap3(j-1:j,i)));
            patch([xx([j-1 j],i-1);xx([j j-1],i)],[Vmap3([j-1 j],i-1);Vmap3([j j-1],i)]*vs+250-3*vs,[zz([j-1 j],i-1);zz([j j-1],i)],[1 1 1],'EdgeColor',c)
        end
    end
    daspect([4 1 4])
    view([135 15])
    ylim([-350 350])
    set(gca,'Ytick',[-250 0 250])
    hold off
    grid on
    %xlabel('x(m)')
    %ylabel('y(m)')
    %zlabel('z(m)')
    
    
%     plottool(1,'mesh',12,'x (m)','z (m)','w(m/s)',['XZ Plane @ y = ',num2str(location),' and t = ',num2str(time)],meshview)
%     mesh(xx,zz,Wmap)
  elseif strcmp(plane,'yz')
      clim = [min(min([Umap Umap2 Umap3])) max(max([Umap Umap2 Umap3]))];
      vc = linspace(clim(1),clim(2),64)';
      %plottool(1,'mesh',12,'y (m)','z (m)','u(m/s)',['YZ Plane @ x = ',num2str(location),' and t = ',num2str(time)],meshview)
      plottool(1,'mesh',12,'y (m)','z (m)','u(m/s)',['Forward Velocity at Multiple X Locations'],meshview)
      %hold off
      hmesh = mesh(yytemp,zz,Umap);
      
      ax = gca;
      colorbar('peer',ax)
      vs = 25;
      %mesh(Umap2*vs,yytemp,zz)
      for i=2:size(xx,2)
          for j=2:size(xx,1)
              c = interp1(vc,cmap,mean(Umap(j-1:j,i)));
              patch([Umap([j-1 j],i-1);Umap([j j-1],i)]*vs-250,[yy(i-1,[j-1 j]) yy(i,[j j-1])],[zz([j-1 j],i-1);zz([j j-1],i)],[1 1 1],'EdgeColor',c)
              hold on
          end
      end
      for i=2:size(xx,2)
          for j=2:size(xx,1)
              c = interp1(vc,cmap,mean(Umap2(j-1:j,i)));
              patch([Umap2([j-1 j],i-1);Umap2([j j-1],i)]*vs,[yy(i-1,[j-1 j]) yy(i,[j j-1])],[zz([j-1 j],i-1);zz([j j-1],i)],[1 1 1],'EdgeColor',c)
          end
      end
      for i=2:size(xx,2)
          for j=2:size(xx,1)
              c = interp1(vc,cmap,mean(Umap3(j-1:j,i)));
              patch([Umap3([j-1 j],i-1);Umap3([j j-1],i)]*vs+250,[yy(i-1,[j-1 j]) yy(i,[j j-1])],[zz([j-1 j],i-1);zz([j j-1],i)],[1 1 1],'EdgeColor',c)
          end
      end
      daspect([1 4 4])
      view([135 15])
      set(gca,'Xtick',[-250 0 250])
      hold off
      grid on
      xlabel('x(m)')
      ylabel('y(m)')
      zlabel('z(m)')
      
  end
end

%%%%%%%%%%%

if PLOTARROWS
  %This will plot an xz cross section and plot arrows instead of a
  %mesh plot
  ystar = 0; %%pick cross section
  tstar = 0;
  plottool(1,'Arrows',12,'x (m)','z (m)','','',[],'ylim',[0 1000])
  %%get data of u and w
  Wmap = zeros(maxDim,maxDim);
  Umap = Wmap;
  for ii = 1:maxDim
    for jj = 1:maxDim
      uvw = uvwout(xx(ii,jj),ystar,zz(ii,jj),tstar,dataloc,1);
      Umap(ii,jj) = uvw(1);
      Wmap(ii,jj) = uvw(3);
    end
  end
  plot(xcoord,height(:,markY),'k-','LineWidth',3)
  grid off
  factor = 10;
  %%Plot arrows
  for ii = 1:maxDim
    for jj = 1:maxDim
      Vmag = sqrt(Umap(ii,jj)^2 + Wmap(ii,jj)^2);
      ulen = factor*(Umap(ii,jj)/Vmag);
      vlen = factor*(Wmap(ii,jj)/Vmag);
      plot([xx(ii,jj) xx(ii,jj)+ulen],[zz(ii,jj) zz(ii,jj)+vlen],'b-')
    end
  end
end
fclose all;

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
