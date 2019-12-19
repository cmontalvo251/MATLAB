function out = interp1save(x,y,xstar,slopelimit)
global mark1D
if ~exist('slopelimit','var')
    slopelimit = realmax;
end
if isempty(mark1D)
  disp('mark1 must be defined as a global')
  out = 0;
  return
end
if xstar <= x(end) && xstar >= x(1)
    %%Test to see if xstar is between mark1 and mark2
    if (xstar > x(mark1D)) && (xstar < x(mark1D+1))
        %%Proceed to end
    else
        %%Find mark1
        mark1D = find(x >= xstar,1);
        if mark1D == length(x)
            mark1D = mark1D - 1;
        end
    end
    mark2 = mark1D + 1;
    slope = (y(mark2) - y(mark1D))/(x(mark2)-x(mark1D));
    if abs(slope) >= slopelimit
        slope = 0;
    end
    out = y(mark1D) + slope*(xstar-x(mark1D));
else
    %out of bounds
    out = 0;
    return
end



% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
