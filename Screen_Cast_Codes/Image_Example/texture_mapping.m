clear
clc
close all

%%%%%IMPORT AN IMAGE

original = imread('world-map.jpg');
imshow(original)

%%%PLOT A SPHERE
[X,Y,Z] = ellipsoid(0,0,0,10,10,10);

figure()
surf(X,Y,-Z)
h = findobj('Type','surface'); %h is a handle - object oriented programming
set(h,'CData',original,'FaceColor','texturemap','edgecolor','none')
grid off
axis off
El = 24;
for Az = 0:360
    view(Az,El)
    pause(0.1)
end

