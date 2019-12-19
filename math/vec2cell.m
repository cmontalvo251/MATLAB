function cellarray = vec2cell(vec)
%function cellarray = vec2cell(vec)
%this will convert a vector into a cellarray with string

cellarray = {};

for ii = 1:length(vec)
  cellarray = [cellarray;num2str(vec(ii))];
end

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
