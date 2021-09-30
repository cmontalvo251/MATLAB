clear
clc
close all

%%%%%IMPORT AN IMAGE

original = imread('world-map.jpg');
imshow(original)

%%%CREATE A SPHERE
R = 10; %%%You can change this to the actual radius of the Earth
N = 24; %%%Number of points to use if you set this to 24 then the longitudes will
%%%be every 15 degrees
[X,Y,Z] = ellipsoid(0,0,0,R,R,R,N);

figure()
surf(X,Y,-Z) %%FLIP THE Z-AXIS
h = findobj('Type','surface'); %h is a handle - object oriented programming
%set(h,'CData',original,'FaceColor','texturemap','edgecolor','none')
set(h,'CData',original,'FaceColor','texturemap') %%%Use this if you want to plot the longitudes

%%%%Let's make sure the texture is aligned with the ECI frame of the Earth
hold on
plot3([0 2*R],[0 0],[0 0],'b-','LineWidth',10) %%%X Axis
plot3([0 0],[0 2*R],[0 0],'r-','LineWidth',10) %%%Y Axis
plot3([0 0],[0 0],[0 2*R],'g-','LineWidth',10) %%%Z Axis

return
grid off
axis off
El = 24;
for Az = 0:360
    view(Az,El)
    pause(0.1)
end

