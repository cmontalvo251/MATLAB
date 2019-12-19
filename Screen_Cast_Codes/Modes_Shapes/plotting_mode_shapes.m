clear
clc
close all

%%%Run your eigen value analysis
v1 = [0.731;1.0];
v2 = [-2.73;1.0];


%%%How do you plot it?
mode1 = [0;v1;0];
plot(mode1,'b-')
mode2 = [0;v2;0];
hold on
plot(mode2,'r-')


%%%Mesh plot
figure()
plot3(1:4,zeros(4,1),mode1,'b-')
hold on
plot3(1:4,ones(4,1),mode2,'r-')
axis equal

xcoord = 1:4;
ycoord = [0 1];

[xx,yy] = meshgrid(xcoord,ycoord)

zz = [mode1';mode2']

surf(xx,yy,zz)

%%%Traingular Coordinates
xFEA = [0,10,0];
yFEA = [0,0,10];
mode_shape = [0,1,-1];

figure()
plot3(xFEA,yFEA,mode_shape,'b*')
hold on
patch(xFEA,yFEA,mode_shape,'r')

%[yyFEA,xxFEA] = meshgrid(yFEA,xFEA)

%zzFEA = [mode_shape',mode_shape',mode_shape']

%surf(xxFEA,yyFEA,zzFEA)

%%%Square FEA
xSQ = [0,10,10,0];
ySQ = [0,0,10,10];
phi = [0.802,0.2488,-0.0308,-0.534];

figure()
plot3(xSQ,ySQ,phi,'b*')
hold on
patch(xSQ,ySQ,phi,'r')

xMESH = [0 10];
yMESH = [0 10];

[xxSQ,yySQ] = meshgrid(xMESH,yMESH)

zzSQ = [phi(1:2);phi([4 3])]

surf(xxSQ,yySQ,zzSQ)