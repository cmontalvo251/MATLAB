function out = bin_add(x,y)
%%This will add binary number x and y where x and y are strings

out = dec2bin(bin2dec(x)+bin2dec(y),length(x));
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
