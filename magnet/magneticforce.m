function F = magneticforce(x,y,z,a,b,c,xc,yc,zc,Br,m)
%%Compute the magnetic force at a point(x,y,z)
%for a cube of size (2a,2b,2c) with center (xc,yc,zc)
%and magnetic charge Br and magnetic moment m

global S T U

F = [0;0;0];

%%Compute T,S,U
S = [(x - xc) - a;(x - xc) + a];
T = [(y - yc) - b;(y - yc) + b];
U = [(z - zc) - c;(z - zc) + c];
S0 = S(1);
S1 = S(2);
T0 = T(1);
T1 = T(2);
U0 = U(1);
U1 = U(2);
%%Compute R
R000 = RNNN(0,0,0);
R001 = RNNN(0,0,1);
R010 = RNNN(0,1,0);
R011 = RNNN(0,1,1);
R100 = RNNN(1,0,0);
R101 = RNNN(1,0,1);
R110 = RNNN(1,1,0);
R111 = RNNN(1,1,1);
sR000 = sqrt(R000);
sR001 = sqrt(R001);
sR010 = sqrt(R010);
sR011 = sqrt(R011);
sR100 = sqrt(R100);
sR101 = sqrt(R101);
sR110 = sqrt(R110);
sR111 = sqrt(R111);
%%Compute Derivatives

%First term
firstterm = [1/((S0*T0/(R000*U0))^2+1),-1/((S0*T0/(R001*U1))^2+1),-1/((S0*T1/(R010*U0))^2+1),1/((S0*T1/(R011*U1))^2+1),-1/((S1*T0/(R100*U0))^2+1),1/((S1*T0/(R101*U1))^2+1),1/((S1*T1/(R110*U0))^2+1),-1/((S1*T1/(R111*U1))^2+1)]';


%Second terms
dBdx = [(R000*U0*T0-S0^2*T0*U0/sR000)/(R000*U0)^2;(R001*U1*T0-S0^2*T0*U1/sR001)/(R001*U1)^2;(R010*U0*T1-S0^2*T1*U0/sR010)/(R010*U0)^2;(R011*U1*T1-S0^2*T1*U1/sR011)/(R011*U1)^2;(R100*U0*T0-S1^2*T0*U0/sR100)/(R100*U0)^2;(R101*U1*T0-S1^2*T0*U1/sR101)/(R101*U1)^2;(R110*U0*T1-S1^2*T1*U0/sR110)/(R110*U0)^2;(R111*U1*T1-S1^2*T1*U1/sR111)/(R111*U1)^2]';

dBdy = [(R000*U0*S0-S0*T0^2*U0/sR000)/(R000*U0)^2;(R001*U1*S0-S0*T0^2*U1/sR001)/(R001*U1)^2;(R010*U0*S0-S0*T1^2*U0/sR010)/(R010*U0)^2;(R011*U1*S0-S0*T1^2*U1/sR011)/(R011*U1)^2;(R100*U0*S1-S1*T0^2*U0/sR100)/(R100*U0)^2;(R101*U1*S1-S1*T0^2*U1/sR101)/(R101*U1)^2;(R110*U0*S1-S1*T1^2*U0/sR110)/(R110*U0)^2;(R111*U1*S1-S1*T1^2*U1/sR111)/(R111*U1)^2]';

dBdz = [(-S0*T0*(R000+U0^2/sR000))/(R000*U0)^2;(-S0*T0*(R001+U1^2/sR001))/(R001*U1)^2;(-S0*T1*(R010+U0^2/sR010))/(R010*U0)^2;(-S0*T1*(R011+U1^2/sR011))/(R011*U1)^2;(-S1*T0*(R100+U0^2/sR100))/(R100*U0)^2;(-S1*T0*(R101+U1^2/sR101))/(R101*U1)^2;(-S1*T1*(R110+U0^2/sR110))/(R110*U0)^2;(-S1*T1*(R111+U1^2/sR111))/(R111*U1)^2]';

%%Compute F
F = m*Br/(4*pi)*[dBdx;dBdy;dBdz]*firstterm;

%%Check for edge
if abs(F(1)) == Inf
  F(1) = 0;
end
if abs(F(2)) == Inf
  F(2) = 0;
end
if abs(F(3)) == Inf
  F(3) = 0;
end

function out = RNNN(ii,jj,kk)
global S T U
ii = ii + 1;
jj = jj + 1;
kk = kk + 1;

out = sqrt(S(ii)^2 + T(jj)^2 + U(kk)^2);


% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
