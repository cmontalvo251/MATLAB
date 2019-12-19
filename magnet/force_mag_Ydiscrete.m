function F = force_mag_Ydiscrete(msize1,msize2,distance,J,N)
%function F = force_mag_d(misze,distance,J)
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
a = msize1(1)/2;
b = msize1(2)/2;
c = msize1(3)/2;
A = msize2(1)/2;
B = msize2(2)/2;
C = msize2(3)/2;
alfa = distance(1);
beta = distance(2);
gamma = distance(3);

xl = [-a a];
yl = [-b b];
bxl = [-A A];
byl = [-B B];
  
x = linspace(xl(1),xl(2),N);
y = linspace(yl(1),yl(2),N);
bx = linspace(bxl(1),bxl(2),N);
by = linspace(byl(1),byl(2),N);

dx = x(2)-x(1);
dy = y(2)-y(1);
dbx = bx(2)-bx(1);
dby = by(2)-by(1);
  
F = [0;0;0];
%counter = 0;
for p = 0:1
  for q = 0:1
    for ii = 1:length(x)-1
      for jj = 1:length(y)-1
	for kk = 1:length(bx)-1
	  for ll = 1:length(by)-1
	    %counter = counter+1
	    xstar = x(ii)+dx/2;
	    ystar = y(jj)+dy/2;
	    bxstar = bx(kk)+dbx/2;
	    bystar = by(ll)+dby/2;
	    U = alfa + bxstar - xstar;
	    V = beta + bystar - ystar;
	    W = gamma + C*(-1)^q - c*(-1)^p;
	    E = 1/(sqrt(U^2+V^2+W^2));
	    wi = ((-1)^(p+q))*(E^3)*[U;V;W];
	    F = F + wi*dx*dy*dbx*dby;
	  end
	end
      end
    end
  end
end

mu0 = 4*pi*(10^-7); %%permeability of free space in T*m/A
F = F*J*J/(4*pi*mu0);

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
