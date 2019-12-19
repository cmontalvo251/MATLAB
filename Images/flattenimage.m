function out = flattenimage(data)

out = uint8((1/3)*(double(data(:,:,1))+double(data(:,:,2))+double(data(:,:,3))));
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
