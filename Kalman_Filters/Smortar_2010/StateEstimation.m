function dxdt = StateEstimation(t,xin,flag)
global NumKalman MASSESTIMATE Sestimate rho_error sosound_error drag_error
global CONFIG ATMOS PROJ BODYAERO CAN RAP FCS TIMESIM DISANALY
global XBODY SIGMA PSIWIND SOS RHO D IP TOMACH NMB
global TOSLCOP TOBLCOP TOWLCOP TOSLMAG TOBLMAG TOWLMAG
global TOSLMAGA2 TOBLMAGA2 TOWLMAGA2
global TOSLMAGA4 TOBLMAGA4 TOWLMAGA4
global TOCX0 TOCX2 TOCNA1 TOCNA3 TOCNGAMA3 TOCY0 TOCZ0
global TOCYPA TOCLP TOCLDD TOCLGAMA2 TOCMQ TOCMQA2
global NBODYFINS SLCG BLCG WLCG WEIGHT
global IXX IYY IZZ IXZ IYZ IXY IXXI IYYI IZZI
global IXYI IXZI IYZI
global XBODYFORCE YBODYFORCE ZBODYFORCE
global LBODYMOMENT MBODYMOMENT NBODYMOMENT
global XFORCE YFORCE ZFORCE
global LinearPlant dCxdM

%%Unwrap States
x = xin(1);
y = xin(2);
z = xin(3);
xdot = xin(4);
ydot = xin(5);
zdot = xin(6);
rho = xin(7);
Cx = -xin(8);
%K = xin(7); %%drag state rho*Cx
m = MASSESTIMATE;
S = Sestimate;
g = 32.2;
if z > 0 && t > 10
  if ~flag
    dxdt = [zeros(NumKalman,1);zeros(sum(NumKalman:-1:1),1)];
  else
    dxdt = zeros(6,1);
  end
else
   %%%TOTAL VELOCITY

   V = sqrt(xdot^2 + ydot^2 + zdot^2);

   %%%COMPUTE THE GUESS OF RHO AND CX

   rhoA = 0.0023784722;
   rhoB = 0.0000068789;
   rhoC = 4.258;

   sosD = 49.0124;
   sosE = 518.4;
   sosF = 0.003566;
   sos = sosD*sqrt(sosE + sosF*z) + sosound_error;
   M = V/sos;
   
   %%%DRAG FORCE

   Dx = 0.5*rho*Cx*V*S*xdot;
   Dy = 0.5*rho*Cx*V*S*ydot;
   Dz = 0.5*rho*Cx*V*S*zdot;

   %%%%STATE DERIVATIVES

   xdbldot = Dx/m;
   ydbldot = Dy/m;
   zdbldot = Dz/m + g;
   
   %%%Derivative of Density
   
   drhodz = rhoA*rhoB*rhoC*(1+rhoB*z)^(rhoC-1);
   rhodot = drhodz*zdot;
   
   %%Derivative of Cx
   
   dsosdz = (sosD*sosF/2)*(sosE + sosF*z)^(-1/2);
   sosdot = dsosdz*zdot;
   Vdot = (xdot*xdbldot + ydot*ydbldot + zdot*zdbldot)/V;
   Mdot = (sos*Vdot-sosdot*V)/(sos^2);
   %%Calculation of dCxdM
   if Cx < TOCX0(1)
     loc = 1;
   elseif Cx > TOCX0(end)
     loc = length(dCxdM);
   else
     loc = find(Cx < TOCX0,1);
   end
   Cxdot = dCxdM(loc)*Mdot;

   if ~flag
   
   %%%%%Plant Model Noise(assumed diagonal)%%%%

   %%If you think your model is terrible you should
   %%make these gains very large
   %%This is a guess at the expected
   %%value of your model noise
   q1 = 0;q2 = 0;q3 = 0;q4 = 0;q5 = 0;q6 = 0;q7 = 0;q8 =0;
   qq = [q1 q2 q3 q4 q5 q6 q7 q8];
   %qq = 1*ones(1,NumKalman);
   Q = diag(qq);

   %%%%%%CONSTRUCT COVARIANCE MATRIX

   pvector = xin(NumKalman+1:end);
   P = zeros(NumKalman,NumKalman);
   for i = 2:NumKalman
      mark = (NumKalman+1)-i;
      P([1:mark],[i:NumKalman]) = P([1:mark],[i:NumKalman]) + diag(pvector(NumKalman+1:(NumKalman+mark)));
      pvector(NumKalman+1:(NumKalman+mark)) = [];
   end
   P = diag(pvector) + P' + P;

   %%%%%COVARIANCE PROPAGATION

   A = LinearPlant;
   Pdot = A*P + P*A' + Q;
   
   %%%%%DECONSTRUCT COVARIANCE MATRIX

   pvectordot = xin(NumKalman+1:end);
   loc = 1;
   for i = 1:NumKalman
      mark = NumKalman+1-i;
      vec = diag(Pdot([1:mark],[i:NumKalman]));
      pvectordot(loc:loc+length(vec)-1) = vec;
      loc = loc + length(vec);
   end

   %pvectordot = zeros(sum(NumKalman:-1:1),1);
   dxdt = [xdot;ydot;zdot;xdbldot;ydbldot;zdbldot;rhodot;Cxdot;pvectordot];
   else
     dxdt = [xdot;ydot;zdot;xdbldot;ydbldot;zdbldot];
   end
end


