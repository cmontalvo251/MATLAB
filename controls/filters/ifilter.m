function out = ifilter(in,p)
%%p must be a number between 0 and 1
%%if p == 1 then out = in
out1 = in;
out2 = in;

for ii = 1:length(in)-1
  out1(ii+1) = p*in(ii+1) + (1-p)*out1(ii);
end

for ii = length(in):-1:2
  out2(ii-1) = p*in(ii-1) + (1-p)*out2(ii);
end

out = 1.*out1 + 0.0.*out2;

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
