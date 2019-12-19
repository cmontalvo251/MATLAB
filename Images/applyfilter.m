function [OUT,coordinates] = applyfilter(IN,mask,radiussize,xx,yy)

[mr,mc] = size(mask);

[r,c] = size(IN);

if mr > r || mc > c
  return;
end

%%Break mask into a column
maskT = zeros(mr*mc,1);
for ii = 1:mr
  maskT(((ii-1)*mc+1):((ii-1)*mc+mc),1) = mask(ii,:)';
end
mask = maskT';

srow = 1;
scol = 1;
erow = r - mr + 1;
ecol = c - mc + 1;

OUT = zeros(r,c);
coordinates = [];
x = zeros(mr*mc,1);
for ii = 1:erow
  for jj = 1:ecol
    %%Get IN data points
    for ll = 1:mr
      start = (ll-1)*mc + 1;
      endpt = (ll-1)*mc + mc;
      x(start:endpt,1) = double(IN(ii-1+ll,jj:jj-1+mc))';
    end
    val = (mask*x);
    %%%%%%%ABOVE 
    if val >= 0.8*sum(mask);
      val = sum(mask);
      coordinates = [coordinates,[xx(ii,jj);yy(ii,jj);radiussize]];
    else
      val = 0;
    end
    OUT(ii,jj) = val;
  end
end

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
