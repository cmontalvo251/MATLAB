function F = force_mag_Kelvin(msize1,msize2,distance,J)
%%Compute the magnetic force between two magnets with separation
%%Note this gives you the force on magnet2
%distance x,y,z,the dimensions of the cubes are a1,b1,c1 and a2,b2,c2
%respectively, They are set up such that a - x , b - y, c - z
%The magnets are polarized in the z direction so care must be
%taken at arbitrary polarization directions with magnitude J
%%msize = [2*a1;2*b1;2*c1];
%distance = [x,y,z] - separation distance between magnets

%%unwrap states
Jprime = norm(J);
a = msize1(1)/2;
b = msize1(2)/2;
c = msize1(3)/2;
A = msize2(1)/2;
B = msize2(2)/2;
C = msize2(3)/2;
alfa = -distance(1);
beta = -distance(2);
gamma = -distance(3); %%distance from center of magnets

F = [0;0;0];

Fx = 0;
Fy = 0;
Fz = 0;
%%Solve for Fx and Fy
for ii = 0:1
  for jj = 0:1
    for kk = 0:1
      for ll = 0:1
	for pp = 0:1
	  for qq = 0:1
	    C1 = -((-1)^ii)*a - alfa;
	    C2 = -((-1)^jj)*b - beta;
	    C3 = -((-1)^kk)*c - gamma;
	    V = B*(-1)^ll + C2;
	    W = C*(-1)^pp + C3;
	    U = A*(-1)^qq + C1;
	    R = sqrt(U^2 + V^2 + W^2);
	    dFxelement = (1/2).*(R.*U+2.*V.*W.*atan(R.^(-1).*U.*V.*W.^(-1))+((-1).*V.^2+W.^2).*log(R+U)+U.*V.*(log(R+(-1).*V)+(-1).*log(R+V)));
	    dFyelement = (1/2).*(R.*V+2.*U.*W.*atan(R.^(-1).*U.*V.*W.^(-1))+U.*V.*(log(R+(-1).*U)+(-1).*log(R+U))+((-1).*U.^2+W.^2).*log(R+V));
	    dFzelement =  real((1/2).*((-2).*(C2+R+U).*W+(-2).*U.*(C2+U).*atan(U.*W.^(-1))+((-1).^(ll+pp).*B.*C+2.*C2.*W).*log(R+V)+(-1).*(-1).^ll.*B.*(W.*log(R+(-1).*V)+(-1).*C3.*log(R+V))+2.*C2.*V.*log(R+W)+(-2).*V.^2.*log(R+W)+sqrt(-1).*C2.*U.*log((sqrt(-1)*2).*((-1).^ll.*B+C2).^(-1).*U.^(-1).*V.^(-2).*(sqrt(-1).*U+W).^(-1).*(U.^2+R.*V+V.^2+(sqrt(-1)*(-1)).*U.*W))+(-1).^ll.*B.*(2.*V.*log(R+W)+sqrt(-1).*U.*(log((sqrt(-1)*2).*((-1).^ll.*B+C2).^(-1).*U.^(-1).*V.^(-2).*(sqrt(-1).*U+W).^(-1).*(U.^2+R.*V+V.^2+(sqrt(-1)*(-1)).*U.*W))+(-1).*log(2.*((-1).^ll.*B+C2).^(-1).*U.^(-1).*(sqrt(-1).*(-1).^pp.*C+sqrt(-1).*C3+U).^(-1).*V.^(-2).*(U.^2+R.*V+V.^2+sqrt(-1).*U.*W))))+(sqrt(-1)*(-1)).*C2.*U.*log(2.*((-1).^ll.*B+C2).^(-1).*U.^(-1).*(sqrt(-1).*(-1).^pp.*C+sqrt(-1).*C3+U).^(-1).*V.^(-2).*(U.^2+R.*V+V.^2+sqrt(-1).*U.*W))+sqrt(-1).*U.*V.*log((sqrt(-1)*2).*U.^(-3).*V.^(-1).*(sqrt(-1).*V+W).^(-1).*(R.*U+U.^2+V.^2+(sqrt(-1)*(-1)).*V.*W))+(sqrt(-1)*(-1)).*U.*V.*log(2.*U.^(-3).*V.^(-1).*(sqrt(-1).*(-1).^pp.*C+sqrt(-1).*C3+V).^(-1).*(R.*U+U.^2+V.^2+sqrt(-1).*V.*W))+(-1).^pp.*C.*U.*log(4.*U.^(-3).*(sqrt(-1).*(-1).^pp.*C+sqrt(-1).*C3+V).^(-1).*(U.*(R+U)+W.*((sqrt(-1)*(-1)).*V+W)))+C3.*U.*log(4.*U.^(-3).*(sqrt(-1).*(-1).^pp.*C+sqrt(-1).*C3+V).^(-1).*(U.*(R+U)+W.*((sqrt(-1)*(-1)).*V+W)))+(-1).^pp.*C.*U.*log((sqrt(-1)*4).*U.^(-3).*(sqrt(-1).*V+W).^(-1).*(U.*(R+U)+W.*(sqrt(-1).*V+W)))+C3.*U.*log((sqrt(-1)*4).*U.^(-3).*(sqrt(-1).*V+W).^(-1).*(U.*(R+U)+W.*(sqrt(-1).*V+W)))));
	    if isnan(dFzelement)
	      %dFzelement = 0;
	    end
	    one = (-1)^(ii+jj+kk+ll+pp+qq);
	    Fx = Fx + (dFxelement)*one;
	    Fy = Fy + (dFyelement)*one;
	    Fz = Fz + (dFzelement)*one;
	  end
	end
      end
    end
  end
end

mu0 = 4*pi*(10^-7); %%permeability of free space in T*m/A

F = [Fx;Fy;Fz].*J*J/(4*pi*mu0);

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


% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
