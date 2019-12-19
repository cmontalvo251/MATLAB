function F = force_mag_YonnetFlip(msize1,msize2,distance,J)
%function F = force_mag_2(msize1,msize2,distance,J)
%%Note this gives you the force on magnet2
%%Compute the magnetic force between two magnets with separation
%distance x,y,z,the dimensions of the cubes are a1,b1,c1 and a2,b2,c2
%respectively, They are set up such that a - x , b - y, c - z
%The magnets are polarized in the z direction so care must be
%taken at arbitrary polarization directions with magnitude J
%%msize = [2*a1;2*b1;2*c1];
%distance = [x,y,z] - separation distance between magnets

%%unwrap states
Jprime = J;
a1 = msize1(1)/2;
b1 = msize1(2)/2;
c1 = msize1(3)/2;
a2 = msize2(1)/2;
b2 = msize2(2)/2;
c2 = msize2(3)/2;
x = distance(1);
y = distance(2);
z = distance(3);

F = [0;0;0];

%%Compute U,V,W
Uij = zeros(2,2);
Vkl = Uij;
Wpq = Vkl;
for ii = 0:1
  for jj = 0:1
    Uij(ii+1,jj+1) = x - a1*(-1)^ii + a2*(-1)^jj;
    Vkl(ii+1,jj+1) = -z + b1*(-1)^ii - b2*(-1)^jj;
    Wpq(ii+1,jj+1) = y - c1*(-1)^ii + c2*(-1)^jj;
  end
end


%Uij = x - [[-a1+a2 -a1-a2];[a1+a2 a1-a2]];
%Vkl = y - [[-b1+b2 -b1-b2];[b1+b2 b1-b2]];
%Wpq = z - [[-c1+c2 -c1-c2];[c1+c2 c1-c2]];

Fx = 0;Fy = 0;Fz = 0;
for ii = 0:1
  for jj = 0:1
    for kk = 0:1
      for ll = 0:1
	for pp = 0:1
	  for qq = 0:1
	    U = Uij(ii+1,jj+1);
	    V = Vkl(kk+1,ll+1);
	    W = Wpq(pp+1,qq+1);
	    R = sqrt(U^2 + V^2 + W^2);
	    one = (-1)^(ii+jj+kk+ll+pp+qq);
	    Fx = Fx + one*phix(U,V,W,R);
	    Fy = Fy + one*phiy(U,V,W,R);
	    Fz = Fz + one*phiz(U,V,W,R);
	  end
	end
      end
    end
  end
end
F = [Fx;Fy;Fz];

mu0 = 4*pi * (10^-7); %%permeability of free space in T*m/A
%mu0 = 1;
F = [Fx;Fy;Fz].*J*Jprime/(4*pi*mu0);

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

function out = phix(U,V,W,R)

out = 0.5*(V^2-W^2)*log(R-U)+U*V*log(R-V)+V*W*atan2(U*V,R*W)+0.5*R*U;

function out = phiy(U,V,W,R)

out = -U*W*log(R-U)-V*W*log(R-V)+U*V*atan2(U*V,R*W)-R*W;

function out = phiz(U,V,W,R)

out = -(0.5*(U^2-W^2)*log(R-V)+U*V*log(R-U)+U*W*atan2(U*V,R*W)+0.5*R*V);



% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
