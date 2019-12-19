function B = magfield(x,y,z,a,b,c,xc,yc,zc,Br)
%%Compute the magnetic field at a point(x,y,z)
%for a cube of size (2a,2b,2c) with center (xc,yc,zc)
%and magnetic charge Br
global S T U

flag = 1;

%%Compute T,S,U
S = [(x - xc) - a;(x - xc) + a];
T = [(y - yc) - b;(y - yc) + b];
U = [(z - zc) - c;(z - zc) + c];

if flag
  B = [0;0;0];
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

  %%Compute B
  B(1) = log(R000-T0)-log(R001-T0)-log(R010-T1)+log(R011-T1)-log(R100-T0)+log(R101-T0)+log(R110-T1)-log(R111-T1);
  B(2) = log(R000-S0)-log(R001-S0)-log(R010-S0)+log(R011-S0)-log(R100-S1)+log(R101-S1)+log(R110-S1)-log(R111-S1);
  B(3) = atan2(S0*T0,R000*U0)-atan2(S0*T0,R001*U1)-atan2(S0*T1,R010*U0)+atan2(S0*T1,R011*U1)-atan2(S1*T0,R100*U0)+atan2(S1*T0,R101*U1)+atan2(S1*T1,R110*U0)-atan2(S1*T1,R111*U1);
  B = B*Br/(4*pi);
else
  Bx = 0;
  By = 0;
  Bz = 0;
  for ii = 0:1
    for jj = 0:1
      for kk = 0:1
	R = RNNN(ii,jj,kk);
	Bx = Bx + log(R-T(jj+1))*(-1)^(ii+jj+kk);
	By = By + log(R-S(ii+1))*(-1)^(ii+jj+kk);
	Bz = Bz + atan2(S(ii+1)*T(jj+1),R*U(kk+1))*(-1)^(ii+jj+kk);
      end
    end
  end
  B = Br/(4*pi).*[Bx;By;Bz];
end

%%Check for edge
if abs(B(1)) == Inf
  B(1) = 0;
end
if abs(B(2)) == Inf
  B(2) = 0;
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
