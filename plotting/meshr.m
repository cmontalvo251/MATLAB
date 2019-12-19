%%This will do the same thing as a mesh plot only it will reverse
%the y-axis
function meshr(xx,yy,data,flag)

mesh(xx,yy,data)
if nargin > 3
  reverse(flag)
end

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
