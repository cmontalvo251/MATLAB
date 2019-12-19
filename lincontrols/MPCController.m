function [dxout,duout] = MPCController(t,dxin)
global Ad Bd

xnominal =  [0;0;-197.331587;0.0;0.136837;0;19.385697;0;2.669367;0;0;0];
xin = dxin + [xnominal(1:3);20;xnominal(4:end)];
xmpc = dxin;

%%Unwrap states
x = xin(1);
y = xin(2);
z = xin(3);
u0 = 19.385697;
phi = xin(5);
theta = xin(6);
psi = xin(7);
u = xin(8);
v = xin(9);
w = xin(10);
p = xin(11);
q = xin(12);
r = xin(13);
theta0 = xnominal(5);
phi0 = xnominal(4);
p0 = xnominal(10);
q0 = xnominal(11);

N = 13; %%No. states
P = 3; %%No. outputs
M = 3; %%No. controls
HP = 3; %%Look ahead
C = [zeros(P,N)];
C(1,8) = 1; %U
C(2,5) = 1; %phi
C(3,6) = 1; %theta
Q = eye(P*HP);
upenalty = 15;
phipenalty = 20;
thetapenalty = 100;
for ii = 1:P
  Q((ii-1)*P+1,(ii-1)*P+1) = upenalty;
  Q((ii-1)*P+2,(ii-1)*P+2) = phipenalty;
  Q((ii-1)*P+3,(ii-1)*P+3) = thetapenalty;
end
R = eye(M*HP);
dTpenalty = 2.5;
dapenalty = 0.1;
depenalty = 0.6;
for ii = 1:M
  R((ii-1)*M+1,(ii-1)*M+1) = depenalty;
  R((ii-1)*M+2,(ii-1)*M+2) = dapenalty;
  R((ii-1)*M+3,(ii-1)*M+3) = dTpenalty;
end
KCA = zeros(HP*P,N);
KCAB = zeros(P*HP,M*HP);
U = zeros(HP*M,1);
prodA = Ad;
for nn = 1:HP
  %%%KCA
  if nn > 1
    prodA = Ad*prodA;
  end
  tempC = C*prodA;
  KCA(P*(nn-1)+1:P*(nn-1)+P,:) = C*prodA;
  %%%KCAB
  rowKCAB = zeros(P,M*HP);
  for ii = 0:nn-1
    rowcolKCAB = C;
    for jj = 1:nn-ii-1
      rowcolKCAB = rowcolKCAB*Ad;
    end
    rowcolKCAB = rowcolKCAB*Bd;
    rowKCAB(:,P*(ii)+1:P*ii+M) = rowcolKCAB;
  end
  KCAB(P*(nn-1)+1:P*(nn-1)+P,:) = rowKCAB;
end
K = inv(KCAB'*Q*KCAB+R)*KCAB'*Q;

MSLOPE = 0;
BINTERCEPT = 0;
ARCLENGTHPARENT = 10;
lbar0 = cos(MSLOPE);
lbar1 = sin(MSLOPE);
planedirection = lbar0*(x-0) + lbar1*(y-BINTERCEPT);
normAC = sqrt(x*x+y*y);
xdot = 20;
ydot = 0;
flightdirection = sign(xdot*lbar0+ydot*lbar1);
xs = 0 + (planedirection + flightdirection*ARCLENGTHPARENT)*lbar0;
ys = BINTERCEPT + (planedirection + flightdirection*ARCLENGTHPARENT)*lbar1;
ys = 6;
zs = -200;
timestepD = 0.01;

%disp('Computing Control')
YCOMMAND = zeros(P*(HP),1);
%%Now populate YCOMMAND
xcoord0 = x;
ycoord0 = y;
zcoord0 = z;
phicoord0 = phi;
thetacoord0 = theta;
p1 = sqrt((xcoord0-x)+sqrt(ycoord0-y)+(zcoord0-z));
for ii = 0:HP-1
  scoord = 0 + (ii+1)/HP;
  xcoord1 = x + scoord*(xs-x);
  ycoord1 = y + scoord*(ys-y);
  zcoord1 = z + scoord*(zs-z);
  p2 = sqrt((xcoord1-x)^2+(ycoord1-y)^2+(zcoord1-z)^2);
  thetacoord1 = -atan2(zcoord1-zcoord0,p2-p1);
  psicoord = atan2(ycoord1-ycoord0,xcoord1-xcoord0);
  phicoord1 = -0.3*(psi-psicoord);
  if abs(phicoord1) > 45*pi/180
    phicoord1 = sign(phicoord1)*45*pi/180;
  end
  if abs(thetacoord1) > 30*pi/180
    thetacoord1 = sign(thetacoord1)*30*pi/180;
  end
  
  phicoord1 = 0.1;
  
  ucoord = 20+4.5*(20-u);
  %ucoord = u0;
  %Reset
  p1 = p2;
  phicoord0 = phicoord1;
  thetacoord0 = thetacoord1;
  xcoord0 = xcoord1;
  ycoord0 = ycoord1;
  zcoord0 = zcoord1;
  %%Now substract nominal values to get deltas
  duii = ucoord - u0;
  dphiii = phicoord1 - phi0;
  dthetaii = thetacoord1 - theta0;
  YCOMMAND((ii)*P+1:(ii)*P+P,1)=[duii;dphiii;dthetaii];
end
KCASTATE = KCA*xmpc;
YKCA = YCOMMAND-KCASTATE;
U = K*(YKCA);
uc = U(1:3);
de = uc(1);
da = uc(2);
dT = uc(3);

duout = [de;da;dT];

dxout = Ad*dxin + Bd*duout;
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
