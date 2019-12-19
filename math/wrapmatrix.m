function mat = wrapmatrix(vec)

l = length(vec);

r = sqrt(l);
c = r;

if r ~= round(r)
    error('Cannot convert vector to matrix since sqrt(length(vec)) is not an integer')
end

mat = zeros(r,c);

for ii = 1:r
  s = (ii-1)*c+1;
  e = s + c-1;
  mat(:,ii) = vec(s:e);
end
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
