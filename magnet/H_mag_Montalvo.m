function H = H_mag_Montalvo(msize1,distance,J)
%function H = H_mag_Montalvo(misze,distance,J)
%%Compute the magnetic field to a point 
%x,y,z,the dimensions of the cube is a1,b1,c1 
%They are set up such that a - x , b - y, c - z
%The magnet is polarized in the z direction so care must be
%taken at arbitrary polarization directions with magnitude J
%%msize = [2*a1;2*b1;2*c1];

%%unwrap states
Jprime = J;
a1 = msize1(1)/2;
b1 = msize1(2)/2;
c1 = msize1(3)/2;
x = distance(1);
y = distance(2);
z = distance(3);

H = [0;0;0];

%%Compute U,V,W
Si = zeros(2,1);
Tj = Si;
for ii = 0:1
    Si(ii+1) = x - a1*(-1)^ii;
    Tj(ii+1) = y - b1*(-1)^ii;
    Wk(ii+1) = z - c1*(-1)^ii;
end

Hx = 0;Hy = 0;Hz = 0;
for ii = 0:1
  for jj = 0:1
    for kk = 0:1
      S = Si(ii+1);
      T = Tj(jj+1);
      W = Wk(kk+1);
      R = sqrt(S^2 + T^2 + W^2);
      one = (-1)^(ii+jj+kk);
      Hx = Hx + one*phix(S,T,W,R);
      Hy = Hy + one*phiy(S,T,W,R);
      Hz = Hz + one*phiz(S,T,W,R);
    end
  end
end

mu0 = 4*pi*(10^-7); %%permeability of free space in T*m/A

H = [Hx;Hy;Hz].*J/(4*pi*mu0);

%%Check for edge
if abs(H(1)) == Inf
  H(1) = 0;
end
if abs(H(2)) == Inf
  H(2) = 0;
end
if abs(H(3)) == Inf
  H(3) = 0;
end

function out = phix(S,T,W,R)

out = (-1).*log(R+T);

function out = phiy(S,T,W,R)

out = (-1).*log(R+S);

function out = phiz(S,T,W,R)

out = atan2(S*T,R*W);



% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
