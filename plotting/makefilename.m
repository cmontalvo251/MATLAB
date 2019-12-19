function filename = makefilename(idx)

filename = '00000000';
num = num2str(idx);
filename = [filename(1:(8-length(num))),num];
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
