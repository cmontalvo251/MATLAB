function Plot6(vec,timeN,xout,conv,dim,save,LegendNames,xout2,xlimits,BodyName)
%function  Plot6(vec,timeN,xout,conv,dim,save,LegendNames,xout2)
%%This function will plot all 12 states of a sixdof simulation
%Inputs are tout and xout and the units(1 for eng and 2 for SI)
%Make sure the data is in columns(i.e r > c)
%%units = 0 for SI and 1 for english
tout = timeN{1};

LineWidth = 2;

%close all

dim1 = 'm';
units = 1;
if nargin > 3
  units = conv;
end
if nargin > 4
  dim1 = dim;
end
if nargin > 7
  data2 = xout2;
  numfiles = length(xout2);
else
  numfiles = 0;
end
if nargin < 6
  save = 0;
end
if nargin < 9
  xlimits = [];
end
if nargin < 10
    BodyName ='';
end

time = tout;
data = xout;
number = 0;
Names = {'X','Y','Z','Phi','Theta','Psi','U','V','W','P','Q','R'};
ylabels = {['x(',dim1,') ',BodyName],['y(',dim1,') ',BodyName],['z(',dim1,') ',BodyName],['\phi (deg) ',BodyName],['\theta (deg) ',BodyName],['\psi (deg) ',BodyName],['u(',dim1,'/s) ',BodyName],['v(',dim1,'/s) ',BodyName],['w(',dim1,'/s) ',BodyName],['p(rad/s) ',BodyName],['q(rad/s) ',BodyName],['r(rad/s) ',BodyName]};
colors = {'r','g','m','c','k'};
%colors = {'k--','k-.','m','c','k'};
for ii = vec
  if ii <= 12
    if ii >= 4 && ii <= 6
      factor = 180/pi;
    else
      factor = units;
    end
    if ii >= 10
      factor = 1;
    end
    %factor = 1;
   plottool(1,Names{ii},18,'Time(sec)',ylabels{ii});
   plot(time,factor.*data(:,ii),'k-','LineWidth',LineWidth)
   if exist('timeN','var')
     for jj = 1:numfiles
       dataN = data2{jj};
       [r,c] = size(dataN);
       val = ii;
       t = timeN{jj+1};
       if c ~= 1
	 plot(t,factor.*dataN(:,val),colors{jj},'LineWidth',LineWidth)
       end
     end
   end
   if exist('LegendNames','var')
       if ~isempty(LegendNames)
           %legend(LegendNames,'Location','NorthEastOutside')
           legend(LegendNames)
       end
   end
   if save
     num = num2str(number);
     zero = zeros(1,5-length(num));
     zero = num2str(zero);
     zero(zero==' ') = [];
     filename = [zero,num];
     saveas(gcf,filename,'jpg');
     number = number + 1;
   end
  end
  if ~isempty(xlimits)
    xlim(xlimits)
  end
end
loc = find(vec == 42,1);
if ~isempty(loc)
  %%Plottools
  [h1,ax1] = plottool(1,'Alfa',18,'Time(sec)','Alfa(deg)');
  [h2,ax2] = plottool(1,'Beta',18,'Time(sec)','Beta(deg)');
  [h3,ax3] = plottool(1,'Total Angle of Attack',12,'Time(sec)','Alfabar(deg)');
  [h4,ax4] = plottool(1,'Vtotal',18,'Time(sec)',['V(',dim1,'/s)']);
  %Plot extra stuff
  uactual = xout(:,7);
  vactual = xout(:,8);
  wactual = xout(:,9);
  %Total velocity
  VtotalA = sqrt(uactual.^2 + vactual.^2 + wactual.^2);
  %%Angle of attack and beta
  alfaA = atan2(wactual,uactual).*180/pi;
  betaA = atan2(vactual,uactual).*180/pi;
  alfabarA = atan2(sqrt(vactual.^2+wactual.^2),uactual).*180/pi;
  plot(ax1,time,alfaA,'k-','LineWidth',LineWidth)
  plot(ax2,time,betaA,'k-','LineWidth',LineWidth)
  plot(ax3,time,alfabarA,'k-','LineWidth',LineWidth)
  plot(ax4,time,VtotalA,'k-','LineWidth',LineWidth)
  if exist('timeN','var')
    for jj = 1:numfiles
      dataN = data2{jj};
      [r,c] = size(dataN);
      t = timeN{jj+1};
      %Plot extra stuff
      uactual = dataN(:,7);
      vactual = dataN(:,8);
      wactual = dataN(:,9);
      %Total velocity
      VtotalA = sqrt(uactual.^2 + vactual.^2 + wactual.^2);
      %%Angle of attack and beta
      alfaA = atan2(wactual,uactual).*180/pi;
      betaA = atan2(vactual,uactual).*180/pi;
      alfabarA = atan2(sqrt(vactual.^2+wactual.^2),uactual).*180/pi;
      if c ~= 1
	plot(ax1,t,alfaA,colors{jj},'LineWidth',LineWidth)
	plot(ax2,t,betaA,colors{jj},'LineWidth',LineWidth)
	plot(ax3,t,alfabarA,colors{jj},'LineWidth',LineWidth)
	plot(ax4,t,VtotalA,colors{jj},'LineWidth',LineWidth)
      end
    end
    if exist('LegendNames','var')
     legend(ax1,LegendNames,'Location','NorthEastOutside')
     legend(ax2,LegendNames,'Location','NorthEastOutside')
     legend(ax3,LegendNames,'Location','NorthEastOutside')
     legend(ax4,LegendNames,'Location','NorthEastOutside')
   end
  end
end
loc = find(vec == 51,1);
if ~isempty(loc)
  %%Altitude vs. Range
  %%Plottools
  [h1,ax1] = plottool(1,'AltvsR',18,'Range(mi)','Altitude(mi)');
  [h2,ax2] = plottool(1,'DeflvsR',18,'Range(mi)','Deflection(ft)');
  %Plot extra stuff
  alt = -xout(:,3)./5280;
  range = xout(:,1)./5280;
  defl = xout(:,2);
  plot(ax1,range,alt,'k-','LineWidth',LineWidth)
  plot(ax2,range,defl,'k-','LineWidth',LineWidth)
  if exist('timeN','var')
    for jj = 1:numfiles
      dataN = data2{jj};
      %[r,c] = size(dataN);
      %Plot extra stuff
      alt = -dataN(:,3)./5280;
      range = dataN(:,1)./5280;
      defl = dataN(:,2);
      plot(ax1,range,alt,colors{jj},'LineWidth',LineWidth)
      plot(ax2,range,defl,colors{jj},'LineWidth',LineWidth)
    end
    legend(ax1,LegendNames,'Location','NorthEastOutside')
    legend(ax2,LegendNames,'Location','NorthEastOutside')
    legend(ax3,LegendNames,'Location','NorthEastOutside')
    legend(ax4,LegendNames,'Location','NorthEastOutside')
  end
end


% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
