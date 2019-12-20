function StateDot = Derivatives(State,xmountain,zmountain)
global mark1D
parameters

%%%Unwrap states
x = State(1);
y = State(2);
z = State(3);
phi = State(4);
theta = State(5);
psi = State(6);
u = State(7);
v = State(8);
w = State(9);
p = State(10);
q = State(11);
r = State(12);

phi_trailer = State(13);
theta_trailer = State(14);
psi_trailer = State(15);
p_trailer = State(16);
q_trailer = State(17);
r_trailer = State(18);

%Compute sines and cosines
ctheta = cos(theta);
stheta = sin(theta);
ttheta = tan(theta);
sphi = sin(phi);
cphi = cos(phi);
spsi = sin(psi);
cpsi = cos(psi);

%%Derivatives

%Kinematics of Humvee
Kxyz = [ctheta*cpsi sphi*stheta*cpsi-cphi*spsi cphi*stheta*cpsi+sphi*spsi;ctheta*spsi sphi*stheta*spsi+cphi*cpsi cphi*stheta*spsi-sphi*cpsi;-stheta sphi*ctheta cphi*ctheta];
xyzdot = Kxyz*[u v w]';

Kptp = [1 sphi*ttheta cphi*ttheta;0 cphi -sphi;0 sphi/ctheta cphi/ctheta];
pqr = [p q r]';
ptpdot = Kptp*pqr;

%%%Kinematics of Trailer
%Compute sines and cosines
cthetat = cos(theta_trailer);
sthetat = sin(theta_trailer);
tthetat = tan(theta_trailer);
sphit = sin(phi_trailer);
cphit = cos(phi_trailer);
spsit = sin(psi_trailer);
cpsit = cos(psi_trailer);
Kptp_trailer = [1 sphit*tthetat cphit*tthetat;0 cphit -sphit;0 sphit/cthetat cphit/cthetat];
pqr_trailer = [p_trailer;q_trailer;r_trailer];
ptpdot_trailer = Kptp_trailer*pqr_trailer;

%%%Control of Throttle
uc = xdot_car;

Thrust = kp*(uc-u);
if Thrust < 0
    Thrust = 0;
end

%%%Contact Model of Humvee
Kuvw = skew(pqr);
XYZ = [0;0;0];
LMN = [0;0;0];
for idx = 1:4
    rTire = [x;y;z] + Kxyz*rcg_Tire(:,idx);

    %%%Interpolate Mountain
    zmountainTire1 = interp1save(xmountain,zmountain,rTire(1));
    %zmountainTire1 = interppatch(centroidsxy,xp,yp,zp,rTire(1),0);
   
    dely = rTire(3)-zmountainTire1;
    
    vTire = [u;v;w] + Kuvw*rcg_Tire(:,idx);

    delydot = vTire(3);

    SpringF = -k*dely - c*delydot;

    if SpringF > 0
        SpringF = 0;
    end
    
    XYZ = XYZ + [0;0;SpringF];
    LMN = LMN + skew(rcg_Tire(:,idx))*[0;0;SpringF];
end
%%Contact Model of Trailer
Kxyz_trailer = R123(phi_trailer,theta_trailer,psi_trailer);
Kuvw_trailer = skew(pqr_trailer);
rTrailer = [x;y;z] + Kxyz*rcg_Hitch + Kxyz_trailer*rH_trailer;
vTrailer = [u;v;w] + Kuvw*rcg_Hitch + Kuvw_trailer*rH_trailer;
LMN_trailer = [0;0;0];
for idx = 1:2
    rTire = rTrailer + Kxyz_trailer*rcgTrailerTires(:,idx);
    
    zmountainTire = interp1save(xmountain,zmountain,rTire(1));
    %zmountainTire = interppatch(centroidsxy,xp,yp,zp,rTire(1),0);
    
    dely = rTire(3)-zmountainTire;
    
    vTire = vTrailer + Kuvw_trailer*rcgTrailerTires(:,idx);
    
    delydot = vTire(3);
    
    SpringF = -k*dely - c*delydot;
    
    if SpringF > 0
        SpringF = 0;
    end
    
    LMN_trailer = LMN_trailer + skew(rcgTrailerTires(:,idx)+rH_trailer)*[0;0;SpringF];
end
    

%%%Add Thrust and Gravity
Fgrav = Kxyz'*[0;0;m*g];
XYZ = XYZ + [Thrust;0;0] + Fgrav;

Fgrav = Kxyz_trailer'*[0;0;m*g];
LMN_trailer = LMN_trailer + skew(rH_trailer)*Fgrav;

%%Dynamics of Humvee
uvwdot = -Kuvw*[u v w]'+XYZ./m;
invI = inv(I);
pqrdot =invI*LMN-invI*(Kuvw*(I*[p q r]'));

%%%Dynamics of Trailer
pqrdot_trailer =invI*LMN_trailer-invI*(Kuvw_trailer*(I*pqr_trailer));

StateDot = [xyzdot;ptpdot;uvwdot;pqrdot;ptpdot_trailer;pqrdot_trailer];

