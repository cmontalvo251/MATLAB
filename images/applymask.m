function OUT = applymask(IN,mask1,mask2)

[mr,mc] = size(mask1);

[r,c] = size(IN);

if mr > r || mc > c
  return;
end

%%Break mask into a column
maskT = zeros(mr*mc,1);
maskT2 = maskT;
for ii = 1:mr
  maskT(((ii-1)*mc+1):((ii-1)*mc+mc),1) = mask1(ii,:)';
  maskT2(((ii-1)*mc+1):((ii-1)*mc+mc),1) = mask2(ii,:)';
end
mask1 = maskT';
mask2 = maskT2';

srow = 1;
scol = 1;
erow = r - mr + 1;
ecol = c - mc + 1;

OUT = zeros(erow,ecol,2);
x = zeros(mr*mc,1);
for ii = 1:erow
  for jj = 1:ecol
    %%Get IN data points
    for ll = 1:mr
      start = (ll-1)*mc + 1;
      endpt = (ll-1)*mc + mc;
      x(start:endpt,1) = double(IN(ii-1+ll,jj:jj-1+mc))';
    end
    OUT(ii,jj,1) = (mask1*x);
    OUT(ii,jj,2) = (mask2*x);
  end
end

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
