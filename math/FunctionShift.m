function [shifted] = FunctionShift(x,original,m,k,slopelimit)
global mark1
%%This function will shift any function by the equation y(x) = f(mx-k)

y = m*x - k;

shifted = 0*original;

for ii = 1:length(y)
  if y(ii) > x(end)
    shifted(ii) = 0;
  elseif y(ii) < x(1)
    shifted(ii) = 0;
  else
    location = find(x == y(ii));
    if isempty(location)
      shifted(ii) = interp1save(x,original,y(ii),slopelimit);
    else
      shifted(ii) = original(location);
    end
  end
end


% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
