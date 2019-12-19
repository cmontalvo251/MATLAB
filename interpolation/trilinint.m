function c = trilinint(x,xl,xu,y,yl,yu,z,zl,zu,clll,cull,cuul,clul,cllu,culu,cuuu,cluu)

cll = clll + ((cull-clll)/(xu-xl))*(x - xl);
cul = clul + ((cuul-clul)/(xu-xl))*(x - xl);
clu = cllu + ((culu-cllu)/(xu-xl))*(x - xl);
cuu = cluu + ((cuuu-cluu)/(xu-xl))*(x - xl);

cl = cll + ((cul-cll)/(yu-yl))*(y - yl);
cu = clu + ((cuu-clu)/(yu-yl))*(y - yl);

c = cl + ((cu-cl)/(zu-zl))*(z - zl);
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
