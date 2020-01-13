function [s1,s2] = gaussian(IN,stdev,N)

[r,c,d] = size(IN);

if d > 1
  %%Flatten image
  newIN = uint8((1/3)*(double(IN(:,:,1))+double(IN(:,:,2))+double(IN(:,:,3))));
  IN = newIN;
end

%%Create Gaussian masks
mask1 = zeros(N,N);
mask2 = mask1;
o1 = stdev(1);
o2 = stdev(2);
limit = (N-1)/2;
m = -limit:limit;
n = m;
for ii = 1:N
  for jj = 1:N
    mi = m(ii);
    nj = n(jj);
    e1 = -(mi^2+nj^2)/(2*o1^2);
    e2 = -(mi^2+nj^2)/(2*o2^2);
    mask1(ii,jj) = exp(e1);
    mask2(ii,jj) = exp(e2);
  end
end
A = sum(sum(mask1))
B = sum(sum(mask2))
mask1 = mask1./(A)
mask2 = mask2./(B)

%%Test grids
[xx,yy] = meshgrid(1:N,1:N);
mesh(xx,yy,mask1)
figure()
mesh(xx,yy,mask2)

%%Apply Masks to image
s = uint8(applymask(IN,mask1,mask2));
s1 = s(:,:,1);
s2 = s(:,:,2);

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
