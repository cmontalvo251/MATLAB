function out = popimage(in)
close all

imshow(in)

out = in;

[r,c] = size(in);

xstar = 30;
c1c2 = inv([xstar xstar^2 ;255 255^2])*[1;255];

indbl = double(in);
outdbl = indbl;

figure()
x = 0:255;
plot(x,c1c2(1)*x + c1c2(2)*x.^2)

invertin = -(indbl-255);

for ii = 1:r
  for jj = 1:c
    xij = invertin(ii,jj);
    f = c1c2(1)*xij + c1c2(2)*xij^2;
    if (f < 0) 
        f = 0; 
    end
    outdbl(ii,jj) = f;
  end
end

invert = -(outdbl-255);

out = uint8(invert);

figure()
imshow(out)

% out = double(out);

% invertim = uint8(-(out - 255));
% invertimdbl = -(out-255);

% figure()
% imshow(invertim)

% brightestval = max(max(max(invertimdbl)));

% stretchinvertdbl = (255/brightestval)*invertimdbl;
% stretchinvert = uint8(invertimdbl);

% figure()
% imshow(stretchinvert)

% out = uint8(-(stretchinvertdbl-255));

% figure()

% imshow(out)

% minin = min(min(min(in)))
% maxin = max(max(max(in)))

% minout = min(min(min(out)))
% maxout = max(max(max(out)))
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
