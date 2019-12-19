purge
data = dlmread('Smortar_DIS.out');
[r,c] = size(data);
plottool(1,'Impact',12,'x','y')
for ii = 1:r
  xy = data(ii,2:3);
  plot(xy(1),xy(2),'b*')
  hold on
end

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
