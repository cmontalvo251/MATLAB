function T = moment_mag_Ydiscrete(msize1,msize2,distance,J,N)
%function T = force_mag_2(msize1,msize2,distance,J)
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
alfa = distance(1);
beta = distance(2);
gamma = distance(3);

T = [0;0;0];

u = linspace(-a1,a1,N);
v = linspace(-b1,b1,N);
w = linspace(-c1,c1,N);
du = u(2)-u(1);
dv = v(2)-v(1);
dw = w(2)-w(1);
Tx = 0;Ty = 0;Tz = 0;
%%Sum dT over entire volume of magnet2
for ww = 1:length(w)
  for vv = 1:length(v)
    for uu = 1:length(u)
      dTx = 0;dTy = 0;dTz = 0;
      %disp(uu+(ww-1)*((length(v)-1)*(length(u)-1))+(vv-1)*(length(u)-1))
      x = u(uu) + alfa;
      y = v(vv) + beta;
      z = w(ww) + gamma;
      for ii = 0:1
	Si(ii+1) = x - a1*(-1)^ii;
	Tj(ii+1) = y - b1*(-1)^ii;
	Wk(ii+1) = z - c1*(-1)^ii;
      end
      for ii = 0:1
	for jj = 0:1
	  for kk = 0:1
	    S = Si(ii+1);
	    T = Tj(jj+1);
	    W = Wk(kk+1);
	    R = sqrt(S^2 + T^2 + W^2);
	    one = (-1)^(ii+jj+kk);
	    r = [a1*(-1)^ii - S/2;b1*(-1)^jj - T/2;c1*(-1)^kk - W/2];
	    F = [dphix(S,T,W,R);dphiy(S,T,W,R);dphiz(S,T,W,R)];
	    dT = cross(r,F);
	    dTx = dTx + one*dT(1);
	    dTy = dTy + one*dT(2);
	    dTz = dTz - one*dT(3);
	  end
	end
      end
      %%Add to T
      Tx = Tx + dTx*du*dv*dw;
      Ty = Ty + dTy*du*dv*dw;
      Tz = Tz + dTz*du*dv*dw;
    end
  end
end


mu0 = 4*pi * (10^-7); %%permeability of free space in T*m/A
%mu0 = 1;
T = [Tx;Ty;Tz].*J*Jprime/(4*pi*mu0);

%%Check for edge
if abs(T(1)) == Inf
  T(1) = 0;
end
if abs(T(2)) == Inf
  T(2) = 0;
end
if abs(T(3)) == Inf
  T(3) = 0;
end

function out = dphix(S,T,W,R)

out = T*W/(R*(S^2+W^2));

function out = dphiy(S,T,W,R)

out = S*W/(R*(T^2+W^2));

function out = dphiz(S,T,W,R)

out = -S*T*(R^2+W^2)/(R*(S^2+W^2)*(T^2+W^2));



% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
