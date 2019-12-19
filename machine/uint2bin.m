function OUT = uint2bin(IN,thresh)

[r,c,d] = size(IN);

if d > 1
  IN = flattenimage(IN);
end

OUT = IN;

OUT(OUT < thresh) = 0;
OUT(OUT > thresh) = 1;

OUT = double(OUT);
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
