function DrawHeli(xc,yc,zc,phi,theta,psi,xt,yt,zt)

%%%%Helicopter Parameters
length = 64; 
width = 17;
height = 17;
rotor_diameter = 53; %%%Feet
hub_z_distance = height;
hub_x_distance = length/4;

%%%Draw Tether Attachment Point
CubeDraw(2,width/2,2,xt,yt-width/4,zt,0,0,0,[1 0 0])

%%%%Draw Main Fuselage
CubeDraw(length/2,width,height,xc+length/4,yc,zc,phi,theta,psi,[0 0 1])

%%%%Draw Tail Boom
CubeDraw(length/2,0.5*width,0.5*height,xc-length/4,yc,zc,phi,theta,psi,[0 1 0])

%%%Draw Main Rotor Disk
[X,Y,Z] = cylinder(rotor_diameter/2);
X = X + xc + hub_x_distance;
Y = Y + yc;
Z = Z + zc - hub_z_distance;
surf(X,Y,Z)

%%%Draw Secondary Rotor
[Xs,Zs,Ys] = cylinder(0.3*rotor_diameter/2);
Xs = Xs + xc - length/2;
Ys = Ys + yc + width/4;
Zs = Zs + zc;
surf(Xs,Ys,Zs)


% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
