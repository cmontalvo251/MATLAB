function c = bilinint(x,xl,xu,y,yl,yu,cll,cul,clu,cuu)

cl = cll + ((cul-cll)/(xu-xl))*(x - xl);
cu = clu + ((cuu-clu)/(xu-xl))*(x - xl);

c = cl + ((cu-cl)/(yu-yl))*(y - yl);
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
