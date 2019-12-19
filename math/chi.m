function y = chi(x,limits)
%%This function takes in a scalar or vector x and returns a 1 if x
%is inbetween the bounds of limits and 0 if it isnt
%%thus limits is a 1x2 vector i.e. limits = [min max];
y = 0*x;
for i = 1:length(x)
  if x(i) >= limits(1) && x(i) < limits(2)
    y(i) = 1;
  end
end

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
