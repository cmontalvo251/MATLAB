function vec = unwrapmatrix(mat)

[r,c] = size(mat);

vec = zeros(1,r*c);

for ii = 1:r
  s = (ii-1)*c+1;
  e = s + c-1;
  vec(1,s:e) = mat(ii,:);
end

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
