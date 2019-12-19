function out = arcfun(y,x)
%%%This function will return a smooth angle from -90 to 90 with no
%%%singularities


out = sign(y).*abs(atan(y./x));

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
