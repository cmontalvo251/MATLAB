clear

clc

close all

sky = imread('world-map.jpg');
scalef = 1;
h1 = figure(1);
[X,Y,Z] = ellipsoid(0,0,0,1,1,1);
surf(X,Y,Z);
h = findobj('Type','surface');
set(h,'CData',flipdim(sky,1),'FaceColor','texturemap','edgecolor','none','FaceLighting','Gouraud','Clipping','off')
view(90,0)