function out = interpsave2(xvec,yvec,data,xstar,ystar)
%%Faster Interpolation
%%mark1 and mark2 are pointers corresponding to the x and y vectors
%%initialize these variables in you main code with mark1 =[ 1 2]; and mark2 = [ 1 2];
global mark1 mark2

c = length(xvec);
out = 0;
%%Check for increasing vectors
if xvec(2) < xvec(1)
  disp('xvec must be increasing');
  return;
end
if yvec(2) < yvec(1)
  disp('yvec must be increasing');
  return;
end
%%%Is xstar and ystar between the marks
%%Check Bounds
if xstar <= xvec(end) && xstar >= xvec(1)
  if ~(xstar >= xvec(mark1(1)) && xstar <= xvec(mark1(2)))
    mark1(1) = find(xstar <= xvec,1);
    if mark1(1) == 1
      mark1 = [1 2];
    else
      mark1 = [mark1(1)-1 mark1(1)];
    end
  end
else
  out = 0;
  %disp('Out of Bounds');
  return;
end
if ystar >= yvec(1) && ystar <= yvec(end)
  if ~(ystar >= yvec(mark2(1)) && ystar <= yvec(mark2(2)))
    mark2(1) = find(ystar <= yvec,1);
    if mark2(1) == 1
      mark2 = [1 2];
    else
        mark2 = [mark2(1)-1 mark2(1)];
      end
  end
else
  out = 0;
  %disp('Out of Bounds');
  return;
end


%%Proceed With 2D Interpolation
x1 = xvec(mark1(1));
x2 = xvec(mark1(2));
y1 = yvec(mark2(1));
y2 = yvec(mark2(2));

%%Q11 through Q22 corresponds to the 4 corners of the square
Q11 = data(mark2(1),mark1(1)); %%make sure that your data vector is oriented in this fashion
Q21 = data(mark2(1),mark1(2));
Q12 = data(mark2(2),mark1(1));
Q22 = data(mark2(2),mark1(2));
R1 = (x2-xstar)*Q11/(x2-x1)+(xstar-x1)*Q21/(x2-x1);
R2 = (x2-xstar)*Q12/(x2-x1)+(xstar-x1)*Q22/(x2-x1);
out = (y2-ystar)*R1/(y2-y1)+(ystar-y1)*R2/(y2-y1);



% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
