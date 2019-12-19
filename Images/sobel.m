function [Gx,Gy,Gxdbl,Gydbl,G] = sobel(IN,N)

[r,c,d] = size(IN);

if d > 1
  %%Flatten image
  newIN = uint8((1/3)*(double(IN(:,:,1))+double(IN(:,:,2))+double(IN(:,:,3))));
  IN = newIN;
end

%%Create sobelmask

if N == 3
  maskx = [-1 -2 -1;0 0 0;1 2 1];
  masky = [-1 0 1;-2 0 2;-1 0 1];
end

%%Apply Masks to image

Gxy = applymask(IN,maskx,masky);
Gxdbl = Gxy(:,:,1);
Gydbl = Gxy(:,:,2);
G = sqrt(Gxdbl.^2 + Gydbl.^2);
Gx = uint8(Gxdbl);
Gy = uint8(Gydbl);
G = uint8(G);

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
