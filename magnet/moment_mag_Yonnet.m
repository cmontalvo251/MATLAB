function M = moment_mag_Yonnet(msize1,msize2,distance,J,flag)
%function M = moment_mag_Yonnet(msize1,msize2,distance,J)
%%Compute the magnetic Moment between two magnets with separation
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
alfa = distance(1);
beta = distance(2);
gamma = distance(3);

M = [0;0;0];
if nargin <= 4
  flag = 0;
end
Mx = 0;My = 0;Mz = 0;
%%Compute F (Total)
Fx=0;Fy=0;Fz=0;
for ii = 0:1
  for jj = 0:1
    for kk = 0:1
      for ll = 0:1
	for qq = 0:1
	  for pp = 0:1
	    U = alfa - a1*(-1)^ii + a2*(-1)^jj;
	    V = beta - b1*(-1)^kk + b2*(-1)^ll;
	    W = gamma - c1*(-1)^pp + c2*(-1)^qq;
	    R = sqrt(U^2 + V^2 + W^2);
	    one = (-1)^(ii+jj+kk+ll+qq+pp);
	    phix = 0.5*(V^2-W^2)*log(R-U)+U*V*log(R-V)+V*W*atan2(U*V,R*W)+0.5*R*U;
	    phiy = 0.5*(U^2-W^2)*log(R-V)+U*V*log(R-U)+U*W*atan2(U*V,R*W)+0.5*R*V;
	    phiz = -U*W*log(R-U)-V*W*log(R-V)+U*V*atan2(U*V,R*W)-R*W;
	    Fx = one*phix;
	    Fy = one*phiy;
	    Fz = one*phiz;
	    corner = [-U/2+a2*(-1)^jj;-V/2+b2*(-1)^ll;-W/2+c2*(-1)^qq];
	    Fc = [Fx;Fy;Fz];
	    dM = cross(corner,Fc);
	    %%Now cross this component with the corners of magnet 2
	    Mx = Mx + dM(1);
	    My = My + dM(2);
	    Mz = Mz + dM(3);
	  end
	end
      end
    end
  end
end
mu0 = 4*pi * (10^-7); %%permeability of free space in T*m/A
M = [Mx;My;Mz].*J*Jprime/(4*pi*mu0);


%%Check for edge
if abs(M(1)) == Inf
  M(1) = 0;
end
if abs(M(2)) == Inf
  M(2) = 0;
end
if abs(M(3)) == Inf
  M(3) = 0;
end


% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
