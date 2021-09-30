
fig = figure();
set(fig,'color','white');
sky = imread('world-map.jpg');
[X,Y,Z] = ellipsoid(0,0,0,10,10,10);

surf(X,Y,Z);
h = findobj('Type','surface');
set(h,'CData',flipdim(sky,1),'FaceColor','texturemap','edgecolor','none','FaceLighting','Gouraud','Clipping','off')
 

