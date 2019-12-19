function plotMB(vec,filename,nobodies)
%function plot6DOF(filename,flag,nobodies)
%%this will and plot all the states of a regular 6dof trajectory
%for multiple bodies

out = dlmread(filename);

tout = out(:,1);
xout = out(:,2:end);

[r,c] = size(xout);

%%Split into multiple Bodies
xTable = zeros(r,13,nobodies);
quats = zeros(r,4,nobodies);
ptp = zeros(r,3,nobodies);
q0 = zeros(r,1);
q1 = q0;
q2 = q0;
q3 = q0;
for ii = 1:nobodies
  s = 1+(ii-1)*13;
  xTable(:,:,ii) = xout(:,s:s+12);
  quats(:,:,ii) = xout(:,s+3:s+6);
  q0 = quats(:,1,ii);
  q1 = quats(:,2,ii);
  q2 = quats(:,3,ii);
  q3 = quats(:,4,ii);
  ptp(:,:,ii) = [atan2(2.*(q0.*q1 + q2.*q3),1-2.*(q1.^2 + q2.^2)),asin(2.*(q0.*q2-q3.*q1)),atan2(2.*(q0.*q3 + q1.*q2),1-2.*(q2.^2 + q3.^2))];
end
%%Quaternion conversion
legendvalues = {'Main Body','Paddle','body3','body4','body5'};
Names = {'X','Y','Z','q0','q1','q2','q3','U','V','W','P','Q','R'};
dim1 = 'm';
colors = {'k-','k--'};
ylabels = {['x(',dim1,')'],['y(',dim1,')'],['z(',dim1,')'],'q0(rad)','q1(rad)','q2(rad)','q3(rad)',['u(',dim1,'/s)'],['v(',dim1,'/s)'],['w(',dim1,'/s)'],'p(rad/s)','q(rad/s)','r(rad/s)'};
data = zeros(r,nobodies);
for ii = vec
  if ii <= 13
    factor = 1;
    h1 = plottool(1,Names{ii},12,'Time(sec)',ylabels{ii});
    for jj = 1:nobodies
      data(:,jj) = xTable(:,ii,jj);
      plot(tout,factor.*data(:,jj),colors{jj},'LineWidth',2)
    end
    legend(legendvalues(1:nobodies))
  end
end
Names = {'Phi(deg)','Theta(deg)','Psi(deg)'};
ylabels = Names;
if find(vec == 42)
  for ii = 1:3
    factor = 180/pi;
    h1 = plottool(1,Names{ii},12,'Time(sec)',ylabels{ii});
    for jj = 1:nobodies
      data(:,jj) = ptp(:,ii,jj);
    end
    plot(tout,factor.*data,'LineWidth',2)
    legend(legendvalues(1:nobodies))
  end
end





% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
