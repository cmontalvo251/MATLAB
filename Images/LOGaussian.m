function [Gx,Gy,Gxdbl,Gydbl,Gdbl,G] = LOGaussian(IN,stdev,N)

[r,c,d] = size(IN);

if d > 1
  %%Flatten image
  newIN = uint8((1/3)*(double(IN(:,:,1))+double(IN(:,:,2))+double(IN(:,:,3))));
  IN = newIN;
end

%%Create Laplacian Gaussian masks
mask1 = zeros(N,N);
mask2 = mask1;
o = stdev;
limit = (N-1)/2;
m = -limit:limit;
n = m;
alfa = 1/(2*pi*o^4);
for ii = 1:N
  for jj = 1:N
    x = m(ii);
    y = n(jj);
    %mask1(ii,jj) = x^2/(2*pi*o^6*exp((x^2 + y^2)/(2*o^2))) - 1/(2*pi*o^4*exp((x^2 + y^2)/(2*o^2)));
    %mask2(ii,jj) = y^2/(2*pi*o^6*exp((x^2 + y^2)/(2*o^2))) - 1/(2*pi*o^4*exp((x^2 + y^2)/(2*o^2)));
    mask1(ii,jj) = -x/(2*pi*o^4*exp((x^2 + y^2)/(2*o^2)));
    mask2(ii,jj) = -y/(2*pi*o^4*exp((x^2 + y^2)/(2*o^2)));
  end
end
%A = sum(sum(mask1))
%B = sum(sum(mask2))
%mask1 = mask1./(A)
%mask2 = mask2./(B)

%%Test grids
figure()
[xx,yy] = meshgrid(1:N,1:N);
mesh(xx,yy,mask1)
figure()
mesh(xx,yy,mask2)

%%Apply Masks to image
Gxy = applymask(IN,mask1,mask2);
Gxdbl = Gxy(:,:,1);
Gydbl = Gxy(:,:,2);
Gdbl = sqrt(Gxdbl.^2 + Gydbl.^2);
Gx = uint8(Gxdbl);
Gy = uint8(Gydbl);
G = uint8(Gdbl);

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
