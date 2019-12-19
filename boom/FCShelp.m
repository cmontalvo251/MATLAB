function FCShelp(filename,vec)
%this function will plot everything in a fcs file

set(0,'defaultlinelinewidth',2)

all = dlmread(filename);

[r,c] = size(all);

time = all(:,1);

for ii = vec
  name = ['YFCS',num2str(ii)];
  plottool(1,name,12,'Time(sec)',name);
  plot(time,all(:,ii+1))
end





% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
