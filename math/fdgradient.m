%%Give a function of x and y and it will return dfdx and dfdy
function [dfdx,dfdy] = fdgradient(f,gridsize)

[r,c] = size(f);

for xthrow = 1:r
  for ythrow = 1:c
    ii = r-ythrow+1;
    jj = xthrow;
    if jj == 1
      %use endpoint method on x
      dfdx(ii,jj) = ((f(ii,jj+1) - f(ii,jj)))/gridsize;
    elseif jj == r
      %use endpoint method
      dfdx(ii,jj) = (f(ii,jj) - f(ii,jj-1))/gridsize;
    else
      %use midpoint method
      dfdx(ii,jj) = (f(ii,jj+1) - f(ii,jj-1))/(2*gridsize);
    end
    if ii == 1
      %use endpoint method on y
      dfdy(ii,jj) = ((f(ii,jj) - f(ii+1,jj)))/gridsize;
    elseif ii == c
      %use endpoint method
      dfdy(ii,jj) = ((f(ii-1,jj) - f(ii,jj)))/gridsize;
    else
      dfdy(ii,jj) = (f(ii-1,jj) - f(ii+1,jj))/(2*gridsize);
    end
  end
end
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
