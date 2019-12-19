function [xm,ym,zm] = patch2surfquick(x,y,z,c)

[r,numpatches] = size(x);

centroidsxy = computecentroids(x,y,z);

%%%Create the meshgrid
xmin = min(min(x));
xmax = max(max(x));
ymin = min(min(y));
ymax = max(max(y));
N = sqrt(numpatches/2);
xstep = (xmax-xmin)/N;
ystep = (ymax-ymin)/N;
xvec = xmin:xstep:xmax;
yvec = ymin:ystep:ymax;

[ym,xm] = meshgrid(yvec,xvec);
zm = 0*ym;

[r,c] = size(xm);

for idx = 1:r
    disp([num2str(idx) ,' out of ', num2str(r)])
    for jdx = 1:c
        %%%Find the patch that you are inside
        yidx = ym(idx,jdx);
        xidx = xm(idx,jdx);
        zm(idx,jdx) = interppatch(centroidsxy,x,y,z,xidx,yidx);
    end
end

plottool(1,'Mesh',18,'x','y','z');
mesh(xm,ym,zm)



% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
