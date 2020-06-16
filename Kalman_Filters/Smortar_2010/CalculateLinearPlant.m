function LinearPlant = CalculateLinearPlant()
global NumKalman MASSESTIMATE Sestimate rho_error sosound_error drag_error
global CONFIG ATMOS PROJ BODYAERO CAN RAP FCS TIMESIM DISANALY
global XBODY SIGMA PSIWIND SOS RHO D IP TOMACH NMB
global TOSLCOP TOBLCOP TOWLCOP TOSLMAG TOBLMAG TOWLMAG
global TOSLMAGA2 TOBLMAGA2 TOWLMAGA2
global TOSLMAGA4 TOBLMAGA4 TOWLMAGA4
global T TFINAL DT
global TOCX0 TOCX2 TOCNA1 TOCNA3 TOCNGAMA3 TOCY0 TOCZ0
global TOCYPA TOCLP TOCLDD TOCLGAMA2 TOCMQ TOCMQA2
global NBODYFINS SLCG BLCG WLCG WEIGHT
global IXX IYY IZZ IXZ IYZ IXY IXXI IYYI IZZI
global IXYI IXZI IYZI
global XBODYFORCE YBODYFORCE ZBODYFORCE
global LBODYMOMENT MBODYMOMENT NBODYMOMENT
global XFORCE YFORCE ZFORCE
global LinearPlant tupdate dCxdM xold

LinearPlant = zeros(6,6);

%%State Parameters

x = xold(1);y = xold(2);z = xold(3);xdot = xold(4);ydot = xold(5);
zdot = xold(6);rho = xold(7);Cx = xold(8);K = rho*Cx;

%%Use Finite Differences Method to Calculate 
%x,y,z,xdot,ydot,zdot derivatives

Fo = StateEstimation(50,xold,1);

%%Perturb State Variables
pert = zeros(8,1);
del = 0.0001;
x = xold(1:8);
for i = 1:6
  pert(i) = del;
  xpert = x + pert;
  F1 = StateEstimation(50,xpert,1);
  LinearPlant(:,i) = (F1-Fo)./del;
  pert(i) = 0;
end

LinearPlant = [[LinearPlant zeros(6,2)];zeros(2,8)];

%%%The Following is only to calculate the last 2 rows
%and the last 2 columns

%%%Speed of Projectile

V = sqrt(xdot^2+ydot^2+zdot^2);
dVdxdot = xdot/V;
dVdydot = ydot/V;
dVdzdot = zdot/V;

%%%Drag

Dx = 0.5*rho*Cx*V*Sestimate*xdot;
Dy = 0.5*rho*Cx*V*Sestimate*ydot;
Dz = 0.5*rho*Cx*V*Sestimate*zdot;

%%Speed of Sound 

sosD = 49.0124;sosE = 518.4;sosF = 0.003566;
sos = sosD*sqrt(sosE + sosF*z) + sosound_error;
dsosdz = (sosD*sosF/2)*(sosE + sosF*z)^(-1/2);
sosdot = dsosdz*zdot;

%%Mach Number

if Cx < TOCX0(1)
  loc = 1;
elseif Cx > TOCX0(end)
  loc = length(dCxdM);
else
  loc = find(Cx < TOCX0,1);
end

m = MASSESTIMATE;
g = 32.2;
xdbldot = Dx/m;ydbldot = Dy/m;zdbldot = Dz/m + g;
Vdot = (xdot*xdbldot + ydot*ydbldot + zdot*zdbldot)/V;
dMdz = -V*dsosdz/(sos^2);
dCxdz = dCxdM(loc)*dMdz;
dMdxdot = dVdxdot/sos;
dMdydot = dVdydot/sos;
dMdzdot = dVdzdot/sos;
dCxdxdot = dCxdM(loc)*dMdxdot;  
dCxdydot = dCxdM(loc)*dMdydot;
dCxdzdot = dCxdM(loc)*dMdzdot;
d2sosdz2 = sosD*(sosF^2)*(-1/4)*(sosE+sosF*z)^(-3/2);
dsosdotdz = d2sosdz2*zdot;

%%Density Parameters

rhoA = 0.0023784722;rhoB = 0.0000068789;rhoC = 4.258;
drhodz = rhoA*rhoB*rhoC*(1+rhoB*z)^(rhoC-1);  

dKdz = drhodz*Cx + rho*dCxdz;  
dKdxdot = rho*dCxdxdot;
dKdydot = rho*dCxdydot;
dKdzdot = rho*dCxdzdot;

%%Linearization of Xdbldot
dDxdz = (1/2)*Sestimate*xdot*V*dKdz;
dDxdxdot = 0.5*Sestimate*(dKdxdot*V*xdot + K*dVdxdot + K*V);
dDxdydot = 0.5*Sestimate*xdot*(dKdydot*V + K*dVdydot);
dDxdzdot = 0.5*Sestimate*xdot*(dKdzdot*V + K*dVdzdot);
dDxdrho = 0.5*V*Sestimate*xdot*Cx;
dDxdCx = 0.5*V*Sestimate*xdot*rho;
LinearPlant(4,7) = dDxdrho/MASSESTIMATE;
LinearPlant(4,8) = dDxdCx/MASSESTIMATE;
%%Linearization of Ydbldot
dDydz = (1/2)*Sestimate*ydot*V*dKdz;
dDydxdot = 0.5*Sestimate*ydot*(dKdxdot*V + K*dVdxdot);
dDydydot = 0.5*Sestimate*(dKdydot*V*ydot + K*dVdydot*ydot + K*V);
dDydzdot = 0.5*Sestimate*ydot*(dKdzdot*V + K*dVdzdot);
dDydrho = 0.5*V*Sestimate*ydot*Cx;
dDydCx = 0.5*V*Sestimate*ydot*rho;
LinearPlant(5,7) = dDydrho/MASSESTIMATE;
LinearPlant(5,8) = dDydCx/MASSESTIMATE;
%%Linearization of Zdbldot
dDzdz = (1/2)*Sestimate*zdot*V*dKdz;
dDzdxdot = 0.5*Sestimate*zdot*(dKdxdot*V + K*dVdxdot);
dDzdydot = 0.5*Sestimate*zdot*(dKdydot*V + K*dVdydot);
dDzdzdot = 0.5*Sestimate*(dKdzdot*V*zdot + K*dVdzdot*zdot + K*V);
dDzdrho = 0.5*V*Sestimate*zdot*Cx;
dDzdCx = 0.5*V*Sestimate*zdot*rho;
LinearPlant(6,7) = dDzdrho/MASSESTIMATE;
LinearPlant(6,8) = dDzdCx/MASSESTIMATE;

%%Linearization of rhodot
d2rhodz2 = rhoA*(rhoB^2)*rhoC*(rhoC-1)*(1+rhoB*z)^(rhoC-1);
drhodotdz = d2rhodz2*zdot;
drhodotdzdot = drhodz;
LinearPlant(7,1) = 0;
LinearPlant(7,2) = 0;
LinearPlant(7,3) = drhodotdz;
LinearPlant(7,4) = 0;
LinearPlant(7,5) = 0;
LinearPlant(7,6) = drhodotdzdot;
LinearPlant(7,7) = 0;
LinearPlant(7,8) = 0;
%%Linearization of Cxdot
dVdotdz = (dDxdz/MASSESTIMATE*xdot + dDydz*ydot/MASSESTIMATE + dDzdz*zdot/MASSESTIMATE)/V;
daVaVdz = dsosdz*Vdot + sos*dVdotdz - dsosdotdz*V;
dMdotdz = ((sos)*daVaVdz - (sos*Vdot - sosdot*V)*2*dsosdz)/(sos^3);
dsosdotdzdot = dsosdz;
dVdotdxdot = (1/V)*(Dx/m + xdot/m*dDxdxdot + ydot/m*dDydxdot + ...
 		    zdot/m*dDzdxdot - Vdot*dVdxdot);
dVdotdydot = (1/V)*(Dy/m + xdot/m*dDxdydot + ydot/m*dDydydot + ...
 		    zdot/m*dDzdydot - Vdot*dVdydot);
dVdotdzdot = (1/V)*(Dz/m + xdot/m*dDxdzdot + ydot/m*dDydzdot + ...
 		    zdot/m*dDzdzdot - Vdot*dVdzdot);
dCxdotdz = dCxdM(loc)*dMdotdz;
dMdotdxdot = (sos*dVdotdxdot - sosdot*dVdxdot)/(sos^2);
dMdotdydot = (sos*dVdotdydot - sosdot*dVdydot)/(sos^2);
dMdotdzdot = (sos*dVdotdzdot - dsosdotdzdot*V - sosdot*dVdydot)/(sos^2);
dCxdotdxdot = dCxdM(loc)*dMdotdxdot;
dCxdotdydot = dCxdM(loc)*dMdotdydot;
dCxdotdzdot = dCxdM(loc)*dMdotdzdot;
LinearPlant(8,1) = 0;
LinearPlant(8,2) = 0;
LinearPlant(8,3) = dCxdotdz;
LinearPlant(8,4) = dCxdotdxdot;
LinearPlant(8,5) = dCxdotdydot;
LinearPlant(8,6) = dCxdotdzdot;
LinearPlant(8,7) = 0;
LinearPlant(8,8) = 0;
