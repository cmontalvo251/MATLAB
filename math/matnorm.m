function out = matnorm(in)
%%%Basically I hate it when you have an NxP matrix and when you type norm
%%%you get one number. That's stupid. I want you to normalize the rows and
%%%give me a 1 column matrix so this code will do just that.

[r,c] = size(in);

if c > r
    error('number of rows must be bigger than columns')
end

out = zeros(r,1);

for idx = 1:r
    out(idx) = norm(in(idx,:));
end
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
