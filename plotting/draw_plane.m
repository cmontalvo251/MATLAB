function out = draw_plane(state,col,wingspan)

%% Wingspan
b = wingspan(1); %(m)
b2 = wingspan(2);
%%SF
SF = [(b/2)/7 (b/2)/7 (b2/2)/7];

% Unwrap state

x = state(1);
y = -state(2);
z = -state(3);

phi = -state(4)+pi;
theta = state(5);
psi = state(6);

ct = cos(theta);
st = sin(theta);
cp = cos(phi);
sp = sin(phi);
cs = cos(psi);
ss = sin(psi);


% Transformation matrices
L1 = [1 0 0; 0 cp sp; 0 -sp cp];
L2 = [ct 0 -st; 0 1 0; st 0 ct];
L3 = [cs ss 0; -ss cs 0; 0 0 1];

T_IB = L3*L2*L1;

%parameters

% Fuselage Front

X = [4 4 4 4];
Y = -[1 1 -1 -1];
Z = -[-.75 1.5 1.5 -.75];

SFMAT = diag(SF);

XYZ = T_IB*SFMAT*[X;Y;Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

hold on

% Fuselage Forward Top

X = [4 -2 -2 4];
Y = -[1 1 -1 -1];
Z = -[1.5 1.5 1.5 1.5];

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% Fuselage Forward Top

X = [4 -2 -2 4];
Y = -[1 1 -1 -1];
Z = -[-.75 -.75 -.75 -.75];

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% Fuselage Forward LS

X = [4 -2 -2 4];
Y = -[-1 -1 -1 -1];
Z = -[1.5 1.5 -.75 -.75];

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% Fuselage Forward LS

X = [4 -2 -2 4];
Y = -[1 1 1 1];
Z = -[1.5 1.5 -.75 -.75];

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% Fuselage Aft Top

X = [-2 -7 -2];
Y = -[1 0 -1];
Z = -[1.5 .75 1.5];

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% Fuselage Aft Bottom

X = [-2 -7 -2];
Y = -[1 0 -1];
Z = -[-.75 0 -.75];

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% Fuselage Aft RS

X = [-2 -7 -7 -2];
Y = -[1 0 0 1];
Z = -[1.5 .75 0 -.75];

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% Fuselage Aft LS

X = [-2 -7 -7 -2];
Y = -[-1 0 0 -1];
Z = -[1.5 .75 0 -.75];

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% Fuselage Aft Bottom

X = [-2 -7 -2];
Y = -[1 0 -1];
Z = -[-.75 0 -.75];

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% Right Wing Top

X = [1.5 1 -.75 -1.5];
Y = -[1 7 7 1];
Z = -[.5 .5 .5 .5];

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% Right Wing Bottom

X = [1.5 1 -.75 -1.5];
Y = -[1 7 7 1];
Z = -[.5 .5 .5 .5];

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% Left Wing Top

X = [1.5 1 -.75 -1.5];
Y = [1 7 7 1];
Z = -[.5 .5 .5 .5];

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% Left Wing Bottom

X = [1.5 1 -.75 -1.5];
Y = [1 7 7 1];
Z = -[.5 .5 .5 .5];

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% H Tail Left Top

X = [-4.8 -5.2 -6.6 -7];
Y = [0 3 3 0];
Z = -[1 1 1 1]*.75;

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% H Tail Left Bottom

X = [-4.8 -5.2 -6.6 -7];
Y = [0 3 3 0];
Z = -[1 1 1 1]*.6;

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% H Tail Left Front

X = [-4.8 -5.2 -5.2 -4.8];
Y = [0 3 3 0];
Z = -[.75 .75 .6 .6];

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% H Tail Left Edge

X = [-5.2 -6.6 -6.6 -5.2];
Y = [3 3 3 3];
Z = -[.75 .75 .6 .6];

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% H Tail Left Back

X = [-6.6 -7.0 -7.0 -6.6];
Y = [3 0 0 3];
Z = -[.75 .75 .6 .6];

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% H Tail Right Top

X = [-4.8 -5.2 -6.6 -7];
Y = -[0 3 3 0];
Z = -[1 1 1 1]*.75;

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% H Tail Right Bottom

X = [-4.8 -5.2 -6.6 -7];
Y = -[0 3 3 0];
Z = -[1 1 1 1]*.6;

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% H Tail Right Front

X = [-4.8 -5.2 -5.2 -4.8];
Y = -[0 3 3 0];
Z = -[.75 .75 .6 .6];

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% H Tail Right Edge

X = [-5.2 -6.6 -6.6 -5.2];
Y = -[3 3 3 3];
Z = -[.75 .75 .6 .6];

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% H Tail Right Back

X = [-6.6 -7.0 -7.0 -6.6];
Y = -[3 0 0 3];
Z = -[.75 .75 .6 .6];

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)


% V Tail Right Side

X = [-5 -6 -7 -7];
Y = [.1 .1 .1 .1];
Z = -[0 2.5 2.5 0];

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% V Tail Left Side

X = [-5 -6 -7 -7];
Y = -[.1 .1 .1 .1];
Z = -[0 2.5 2.5 0];

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% V Tail Top

X = [-6 -7 -7 -6];
Y = [.1 .1 -.1 -.1];
Z = -[2.5 2.5 2.5 2.5];

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% V Tail Front

X = [-5 -6 -6 -5];
Y = [.1 .1 -.1 -.1];
Z = -[0 2.5 2.5 0];

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

% V Tail Back

X = [-7 -7 -7 -7];
Y = [-.1 -.1 .1 .1];
Z = -[0 2.5 2.5 0];

XYZ = T_IB*SFMAT*[X; Y; Z];
fill3(XYZ(1,:)+x,-XYZ(2,:)-y,-XYZ(3,:)-z,col)

%axis equal

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
