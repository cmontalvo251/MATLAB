function [xm,ym,zm] = patch2surf(filename)
%filename = '~/Desktop/Rocky_Terrain.stl';

[x,y,z,c] = stlread(filename);

plottool(1,'Mesh',18,'x','y','z');
patch(x,y,z,z)
[r,numpatches] = size(x);

xvals = zeros(3*numpatches,1);
yvals = xvals;
zvals = yvals;

for idx = 1:numpatches
    %disp([num2str(idx),' out of ',num2str(numpatches)])
    s = (idx-1)*3 + 1;
    e = s + 2;
    xvals(s:e) = x(:,idx);
    yvals(s:e) = y(:,idx);
    zvals(s:e) = z(:,idx);
end

%%%Create mesh
xvec = sort(xvals);
yvec = sort(yvals);

%%%Run your own unique since this versions unique is not that great
keepx = 0*xvec;
keepy = 0*yvec;
keepx(1) = 1;
keepy(1) = 1;
ctrx = 2;
ctry = 2;
for idx = 1:length(xvec)-1
    if abs(xvec(idx+1)-xvec(idx)) > 0.1
        keepx(ctrx) = idx+1;
        ctrx = ctrx + 1;
    end
    if abs(yvec(idx+1)-yvec(idx)) > 0.1
        keepy(ctry) = idx+1;
        ctry = ctry + 1;
    end
end
keepx(ctrx:end) = [];
keepy(ctry:end) = [];

xvec = xvec(keepx);
yvec = yvec(keepy);

xlimit = max(xvec(2:end)-xvec(1:end-1));
ylimit = max(yvec(2:end)-yvec(1:end-1));

[ym,xm] = meshgrid(yvec,xvec);
zm = 0*ym;

[r,c] = size(xm);

%%%Loop through meshes to get zcoordinate
for idx = 1:r
    disp([num2str(idx),' out of ',num2str(r)])
    for jdx = 1:c
        %disp([num2str(jdx),' out of ',num2str(c)])
        xidx = xm(idx,jdx);
        yidx = ym(idx,jdx);
        %disp([xidx,yidx])
        xfind = find(abs(xvals-xidx)<xlimit);
        yfind = find(abs(yvals-yidx)<ylimit);
        if length(xfind) < length(yfind)
            search = xfind;
            L = length(xfind);
            other = yfind;
        else
            search = yfind;
            L = length(yfind);
            other = xfind;
        end
        kdx = 0;
        %loc = [];
        notfound = 1;
        while notfound && kdx < L
        %for kdx = 1:length(search)
            kdx = kdx + 1;
            zeroed = other - search(kdx);
            loc = find(zeroed == 0);
            if ~isempty(loc)
                notfound = 0;
            end
        end
        kdx = other(loc);
        zm(idx,jdx) = zvals(kdx);
        %kall = other(loc(1));
        %xvals(kall) = [];
        %yvals(kall) = [];
        %zvals(kall) = [];
    end
end
plottool(1,'Mesh',18,'x','y','z');
mesh(xm,ym,zm)



% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
