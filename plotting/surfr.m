%%This will do the same thing as a surf plot only it will reverse
%the y-axis
function surfr(xx,yy,data,flag,extra)

command = ['surf(xx,yy,data'];
if exist('extra')
    s = max(size(extra));
    for ii = 1:s
        command = [command,',',extra{ii}];
    end
end
command = [command,');'];
eval(command)
if flag
  reverse(flag);
end
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
