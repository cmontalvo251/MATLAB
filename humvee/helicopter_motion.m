function xyzptp = helicopter_motion(xyzptp_trailer)

%%%Helicopter parameters (From trailer to heli)
SLHELI = -0.4;
BLHELI = 0;
WLHELI = -1.50629+0.25;

%%%%Allocate Vectors
xT = xyzptp_trailer(:,1);
yT = xyzptp_trailer(:,2);
zT = xyzptp_trailer(:,3);
pT = xyzptp_trailer(:,4);
tT = xyzptp_trailer(:,5);
sT = xyzptp_trailer(:,6);
xH = xT;
yH = xT;
zH = xT;

parameters

%%%Distance from Trailer to Helicopter
rTH_B = [SLHELI;BLHELI;WLHELI];

for idx = 1:length(xH)
    phi = pT(idx);
    theta = tT(idx);
    psi = tT(idx);
    TIB = R123(phi,theta,psi);
    rTH_I = TIB*rTH_B;
    xH(idx) = xT(idx) + rTH_I(1);    
    yH(idx) = yT(idx) + rTH_I(2);
    zH(idx) = zT(idx) + rTH_I(3);
end

pH = pT;
tH = tT;
sH = sT;

xyzptp = [xH,yH,zH,pH,tH,sH];


