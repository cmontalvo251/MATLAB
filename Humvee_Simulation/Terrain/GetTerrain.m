purge

filename = 'Rocky_Terrain.stl';

[xp,yp,zp,cp] = stlread(filename);

plottool(1,'Patch',18,'x','y','z');
patch(xp,yp,zp,zp,'edgecolor','k')

centroidsxy = computecentroids(xp,yp,zp);
yidx = 0;
%plottool(1,'Interpolated Patches',18,'x','y','z')
for xidx = -50:2:100
    zm = interppatch(centroidsxy,xp,yp,zp,xidx,yidx);
end

%[xm,ym,zm] = patch2surfquick(xp,yp,zp,cp);

%dlmwrite('xterrainfast.txt',xm);
%dlmwrite('yterrainfast.txt',ym);
%dlmwrite('zterrainfast.txt',zm);

