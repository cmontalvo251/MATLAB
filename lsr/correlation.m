function rxy = correlation(x,y)

num = 0;
den1 = 0;
den2 = 0;
for ii = 1:length(y)
   num = num + (y(ii)-mean(y))*(x(ii)-mean(x));
   den1 = den1 + (y(ii)-mean(y))^2;
   den2 = den2 + (x(ii)-mean(x))^2;
end
rxy = num/(sqrt(den1*den2));
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
