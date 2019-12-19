function c = silinint(y,yl,yu,cl,cu)

c = cl + ((cu-cl)/(yu-yl))*(y - yl);
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
