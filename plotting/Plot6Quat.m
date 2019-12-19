function Plot6Quat(vec,timeN,xout,conv,dim,xoutN,LegendNames,BodyName)
%function Plot6Quat(vec,timeN,xout,conv,dim,xoutN)
%%This function will plot all 12 states of a sixdof simulation
%Inputs are tout and xout and the units(1 for eng and 2 for SI)
%Make sure the data is in columns(i.e r > c)
time = timeN{1};
data = xout;
dim1 = 'm';
units = 1;
if nargin > 3
  units = conv;
end
if nargin > 4
  dim1 = dim;
end

if nargin > 5
  numfiles = length(xoutN);
  dataN = xoutN;
else
  numfiles = 0;
end
LegendON = 1;
if nargin < 7
  LegendNames = '';
  LegendON = 0;
else
    if length(LegendNames) == 0;
        LegendON = 0;
    end
end
if nargin < 8
    BodyName = '';
end
Names = {['X ',BodyName],['Y ',BodyName],['Z ',BodyName],['q0 ',BodyName],['q1 ',BodyName],['q2 ',BodyName],['q3 ',BodyName],['U ',BodyName],['V ',BodyName],['W ',BodyName],['P ',BodyName],['Q ',BodyName],['R ',BodyName]};
maincolor = 'k-';
colors = {'k-.','k--','k:'};
ylabels = {['x(',dim1,') ',BodyName],['y(',dim1,') ',BodyName],['z(',dim1,') ',BodyName],['q0(rad) ',BodyName],['q1(rad) ',BodyName],['q2(rad) ',BodyName],['q3(rad) ',BodyName],['u(',dim1,'/s) ',BodyName],['v(',dim1,'/s) ',BodyName],['w(',dim1,'/s) ',BodyName],['p(rad/s) ',BodyName],['q(rad/s) ',BodyName],['r(rad/s) ',BodyName]};
for ii = vec
  if ii <= 13
    factor = units;
    if ii == 3
      %factor = -factor;
    end
    h1 = plottool(1,Names{ii},18,'Time(sec)',ylabels{ii});
    plot(time,factor.*data(:,ii),maincolor,'LineWidth',2)
    if exist('timeN','var')
        for jj = 1:numfiles
            t = timeN{jj+1};
            data2 = dataN{jj};
            plot(t,factor.*data2(:,ii),colors{jj})
        end
        if LegendON
            h1 = legend(LegendNames);
            set(h1,'Interpreter','None')
        end
        %xlim([0 77])
    end
  end
end
if find(vec ==40)
    if numfiles
        ptp = quat2euler(data(:,4:7),0,time,'Towed');
        data2 = dataN{1};
        ptp2 = quat2euler(data2(:,4:7),0,time,'Towed');
        eangle = {['\phi (deg) ',BodyName],['\theta (deg) ',BodyName],['\psi (deg) ',BodyName]};
        for ii = 1:3
            h1 = plottool(1,'Euler Angle',18,'Time(sec)',eangle{ii});
            plot(time,180/pi.*ptp(:,ii),maincolor)
            plot(time,180/pi.*ptp2(:,ii),colors{2})
            h1 = legend(LegendNames);
            set(h1,'Interpreter','None')
        end
    else
        ptp = quat2euler(data(:,4:7),1,time,'Towed');
    end
end
% phi = 0;
% theta = 1.08;
% psi = 0;

% q0 = cos(phi/2).*cos(theta/2).*cos(psi/2) + sin(phi/2).*sin(theta/2).*sin(psi/2)
% q1 = sin(phi/2).*cos(theta/2).*cos(psi/2) - cos(phi/2).*sin(theta/2).*sin(psi/2)
% q2= cos(phi/2).*sin(theta/2).*cos(psi/2) + sin(phi/2).*cos(theta/2).*sin(psi/2)
% q3 = cos(phi/2).*cos(theta/2).*sin(psi/2) - sin(phi/2).*sin(theta/2).*cos(psi/2)

if find(vec==42)
  %%Altitude vs x
  plottool(1,'ZvsX',12,'x(m)','z(m)');
  plot(data(:,1),-data(:,3),maincolor)
  if nargin > 4
    for jj = 1:numfiles
      t = timeN{jj};
      data2 = dataN{jj};
      plot(data2(:,1),-data2(:,3),colors{jj})
    end
    h1 = legend(LegendNames);
    set(h1,'Interpreter','None')
    ylim([0 max(-data(:,3))+1000])
  end
  %%x vs y
  plottool(1,'YvsX',12,'x(m)','y(m)');
  plot(data(:,1),data(:,2),maincolor)
  if nargin > 4
    for jj = 1:numfiles
      t = timeN{jj+1};
      data2 = dataN{jj};
      plot(data2(:,1),data2(:,2),colors{jj})
    end
    h1 = legend(LegendNames);
    set(h1,'Interpreter','None')
  end
  %axis equal
  q0 = xout(:,4);
  q1 = xout(:,5);
  q2 = xout(:,6);
  q3 = xout(:,7);
  phi = (atan2(2.*(q0.*q1 + q2.*q3),1-2.*(q1.^2 + q2.^2)));
  theta = asin(2.*(q0.*q2-q3.*q1));
  psi = atan2(2.*(q0.*q3 + q1.*q2),1-2.*(q2.^2 + q3.^2));
  eangle1 = [phi,theta,psi];
  if nargin > 4
    eangleN = {};
    for jj = 1:numfiles
      t = timeN{jj+1};
      xout2 = dataN{jj};
      q0 = xout2(:,4);
      q1 = xout2(:,5);
      q2 = xout2(:,6);
      q3 = xout2(:,7);
      phi2 = (atan2(2.*(q0.*q1 + q2.*q3),1-2.*(q1.^2 + q2.^2)));
      theta2 = asin(2.*(q0.*q2-q3.*q1));
      psi2 = atan2(2.*(q0.*q3 + q1.*q2),1-2.*(q2.^2 + q3.^2));
      eangles = [phi2,theta2,psi2];
      eangleN = [eangleN eangles];
    end
  end
  eangle = {['\phi (deg) ',BodyName],['\theta (deg) ',BodyName],['\psi (deg) ',BodyName]};
  for ii = 1:3
    h1 = plottool(1,'Euler Angle',18,'Time(sec)',eangle{ii});
    plot(time,180/pi.*eangle1(:,ii),maincolor)
    if exist('timeN','var')
      for jj = 1:numfiles
	t = timeN{jj+1};
	eangle2 = eangleN{jj};
	plot(t,180/pi.*eangle2(:,ii),colors{jj})
      end
      h1 = legend(LegendNames);
      set(h1,'Interpreter','None')
    end
  end
  %Plot extra stuff
  uactual = xout(:,8);
  vactual = xout(:,9);
  wactual = xout(:,10);
  %No roll frame velocities
  vnoroll = cos(phi).*vactual - sin(phi).*wactual;
  wnoroll = sin(phi).*vactual + cos(phi).*wactual;
  [h1,ax1] = plottool(1,'vnoroll',12,'Time(sec)',['v (',dim1,'/s)']);
  [h2,ax2] = plottool(1,'wnoroll',12,'Time(sec)',['w (',dim1,'/s)']);
  plot(ax1,time,vnoroll,maincolor)
  plot(ax2,time,wnoroll,maincolor)
  if exist('timeN','var')
    for jj = 1:numfiles
      t = timeN{jj+1};
      xout2 = dataN{jj};
      u = xout2(:,8);
      v = xout2(:,9);
      w = xout2(:,10);
      %Total velocity
      q0 = xout2(:,4);
      q1 = xout2(:,5);
      q2 = xout2(:,6);
      q3 = xout2(:,7);
      phi2 = (atan2(2.*(q0.*q1 + q2.*q3),1-2.*(q1.^2 + q2.^2)));
      vnoroll2 = cos(phi2).*v - sin(phi2).*w;
      wnoroll2 = sin(phi2).*v + cos(phi2).*w;
      plot(ax1,t,vnoroll2,colors{jj})
      plot(ax2,t,wnoroll2,colors{jj})
    end
    l1 = legend(ax1,LegendNames);
    set(l1,'Interpreter','None')
    l2 = legend(ax2,LegendNames);
    set(l2,'Interpreter','None')
  end
  uactual = xout(:,8);
  vactual = xout(:,9);
  wactual = xout(:,10);
  %Total velocity
  VtotalA = sqrt(uactual.^2 + vactual.^2 + wactual.^2);
  h1 = plottool(1,'Vtotal',12,'Time(sec)',['V(',dim1,'/s)']);
  plot(time,VtotalA,maincolor)
  if exist('timeN','var')
    for jj = 1:numfiles
      t = timeN{jj+1};
      xout2 = dataN{jj};
      u = xout2(:,8);
      v = xout2(:,9);
      w = xout2(:,10);
      %Total velocity
      Vtotal2 = sqrt(u.^2 + v.^2 + w.^2);
      plot(t,Vtotal2,colors{jj})
    end
    h1 = legend(LegendNames);
    set(h1,'Interpreter','None')
  end
  %%Angle of attack and beta
  alfaA = atan2(wactual,uactual).*180/pi;
  betaA = atan2(vactual,uactual).*180/pi;
  alfabarA = atan2(sqrt(vactual.^2+wactual.^2),uactual).*180/pi;
  h1 = plottool(1,'Alfa',12,'Time(sec)','Alfa(deg)');
  plot(time,alfaA,maincolor)
  h1 = gca;
  h2 = plottool(1,'Beta',12,'Time(sec)','Beta(deg)');
  plot(time,betaA,maincolor)
  h2 = gca;
  h3 = plottool(1,'Total Angle of Attack',18,'Time(sec)','Alfabar(deg)');
  plot(time,alfabarA,maincolor)
  h3 = gca;
  if exist('timeN','var')
    for jj = 1:numfiles
      t = timeN{jj+1};
      xout2 = dataN{jj};
      u = xout2(:,8);
      v = xout2(:,9);
      w = xout2(:,10);
      alfa2 = atan2(w,u).*180/pi;
      beta2 = atan2(v,u).*180/pi;
      alfabar2 = atan2(sqrt(v.^2+w.^2),u).*180/pi;
      plot(h1,t,alfa2,colors{jj})
      plot(h2,t,beta2,colors{jj})
      plot(h3,t,alfabar2,colors{jj})
    end
    h1l = legend(h1,LegendNames);
    set(h1l,'Interpreter','None')
    h2l = legend(h2,LegendNames);
    set(h2l,'Interpreter','None')
    h3l = legend(h3,LegendNames);
    set(h3l,'Interpreter','None')
  end
end


% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
