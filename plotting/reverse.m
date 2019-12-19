%%This will reverse the axis frame of your ploting scheme
function reverse(flag)

for ii = 1:length(flag)
  if strcmp(flag(ii),'y')
    set(gca,'YDir','reverse')
  elseif strcmp(flag(ii),'z')
    set(gca,'ZDir','reverse')
  end
  if strcmp(flag(ii),'x')
    set(gca,'XDir','reverse')
  end
end

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
