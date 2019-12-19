function out = sat(y)

if abs(y) <= 1
  out = y;
else
  out = sign(y);
end

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
