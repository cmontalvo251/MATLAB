function UpdateAttitudeVector()

global pvectorPTP RPTP pqrold ptpold magfield
global pqrnew ptpnew ptpmeasured NumMAG Numptp
global magmeasured magderivfiltered MAGupdatecounter

%%UnWrap States
p = pqrold(1);
q = pqrold(2);
r = pqrold(3);
phi = ptpold(1);
theta = ptpold(2);
psi = ptpold(3);
cphi = cos(phi);sphi = sin(phi);
ctheta = cos(theta);stheta = sin(theta);
cpsi = cos(psi);spsi = sin(psi);
magdata = magmeasured(:,MAGupdatecounter);
magderivdata = magderivfiltered(:,MAGupdatecounter);
mxi = magfield(1);
myi = magfield(2);
mzi = magfield(3);

%%Update State Using Kalman Filter
%%Construct Covariance Matrix
Pold = zeros(Numptp,Numptp);
for jj = 2:Numptp
  mark = (Numptp+1)-jj;
  Pold([1:mark],[jj:Numptp]) = Pold([1:mark],[jj:Numptp]) + diag(pvectorPTP(Numptp+1:(Numptp+mark)));
  pvectorPTP(Numptp+1:(Numptp+mark)) = [];
end
Pold = diag(pvectorPTP) + Pold' + Pold;

%%Calculate the Cptp matrix
Cptp = zeros(NumMAG,Numptp);
Cptp(1,1) = 0;
Cptp(1,2) = - mzi*ctheta - mxi*cpsi*stheta - myi*spsi*stheta;
Cptp(1,3) = myi*cpsi*ctheta - mxi*ctheta*spsi;
Cptp(2,1) = mxi*(sphi*spsi + cphi*cpsi*stheta) - myi*(cpsi*sphi - cphi*spsi*stheta) + mzi*cphi*ctheta;
Cptp(2,2) = mxi*cpsi*ctheta*sphi - mzi*sphi*stheta + myi*ctheta*sphi*spsi;
Cptp(2,3) = - mxi*(cphi*cpsi + sphi*spsi*stheta) - myi*(cphi*spsi - cpsi*sphi*stheta);
Cptp(3,1) = mxi*(cphi*spsi - cpsi*sphi*stheta) - myi*(cphi*cpsi + sphi*spsi*stheta) - mzi*ctheta*sphi;
Cptp(3,2) = mxi*cphi*cpsi*ctheta - mzi*cphi*stheta + myi*cphi*ctheta*spsi;
Cptp(3,3) = mxi*(cpsi*sphi - cphi*spsi*stheta) + myi*(sphi*spsi + cphi*cpsi*stheta);
Cptp(4,1) = mzi*(r*cphi*ctheta + q*ctheta*sphi) - mxi*(q*(cphi*spsi - cpsi*sphi*stheta) - r*(sphi*spsi + cphi*cpsi*stheta)) + myi*(q*(cphi*cpsi + sphi*spsi*stheta) - r*(cpsi*sphi - cphi*spsi*stheta));
Cptp(4,2) = mzi*(q*cphi*stheta - r*sphi*stheta) - mxi*(q*cphi*cpsi*ctheta - r*cpsi*ctheta*sphi) - myi*(q*cphi*ctheta*spsi - r*ctheta*sphi*spsi);
Cptp(4,3) = - mxi*(q*(cpsi*sphi - cphi*spsi*stheta) + r*(cphi*cpsi + sphi*spsi*stheta)) - myi*(q*(sphi*spsi + cphi*cpsi*stheta) + r*(cphi*spsi - cpsi*sphi*stheta));
Cptp(5,1) = mxi*p*(cphi*spsi - cpsi*sphi*stheta) - myi*p*(cphi*cpsi + sphi*spsi*stheta) - mzi*p*ctheta*sphi;
Cptp(5,2) = mxi*(r*cpsi*stheta + p*cphi*cpsi*ctheta) + myi*(r*spsi*stheta + p*cphi*ctheta*spsi) + mzi*(r*ctheta - p*cphi*stheta);
Cptp(5,3) = myi*(p*(sphi*spsi + cphi*cpsi*stheta) - r*cpsi*ctheta) + mxi*(p*(cpsi*sphi - cphi*spsi*stheta) + r*ctheta*spsi);
Cptp(6,1) = myi*p*(cpsi*sphi - cphi*spsi*stheta) - mxi*p*(sphi*spsi + cphi*cpsi*stheta) - mzi*p*cphi*ctheta;
Cptp(6,2) = - mxi*(q*cpsi*stheta + p*cpsi*ctheta*sphi) - myi*(q*spsi*stheta + p*ctheta*sphi*spsi) - mzi*(q*ctheta - p*sphi*stheta);
Cptp(6,3) = myi*(p*(cphi*spsi - cpsi*sphi*stheta) + q*cpsi*ctheta) + mxi*(p*(cphi*cpsi + sphi*spsi*stheta) - q*ctheta*spsi);

%%Calculate Estimates of Measurements
tbi(1,1) = ctheta*cpsi;
tbi(1,2) = ctheta*spsi;
tbi(1,3) = -stheta;
tbi(2,1) = sphi*stheta*cpsi - cphi*spsi;
tbi(2,2) = sphi*stheta*spsi + cphi*cpsi;
tbi(2,3) = sphi*ctheta;
tbi(3,1) = cphi*stheta*cpsi + sphi*spsi;
tbi(3,2) = cphi*stheta*spsi - sphi*cpsi;
tbi(3,3) = cphi*ctheta;
wcross = [0 r -q;-r 0 p;q -p 0];
mbestimate = tbi*magfield;
mbdotestimate = wcross*mbestimate;
z = [magdata;magderivdata];
zo = [mbestimate;mbdotestimate];
if NumMAG == 3;
  Cptp = Cptp(1:3,1:3);
  z = z(1:NumMAG);
  zo = zo(1:NumMAG);
  iC = inv(Cptp);
else
  iC = pinv(Cptp);
end
if isnan(iC(1,1)) || isinf(iC(1,1))
  iC = eye(3);
end
ptpmeasured(1:3,MAGupdatecounter) = iC*(z-zo) + ptpold;

%%%%%Kalman Gain

K = Pold*Cptp'*inv(RPTP + Cptp*Pold*Cptp');
if isnan(K(1,1)) || isinf(K(1,1))
  K = zeros(Numptp,NumMAG);
end

%%%%%%%%%%%%%%%%

%%%%%%%%%State Update

%%Statesmeasured is [mxb,myb,mzb,mxbdot,mybdot,mzbdot]
%Magnetometer provides this data

ptpnew = ptpold + K*(z - zo);
MAGupdatecounter = MAGupdatecounter + 1;
ptpold = ptpnew;

%%%%%%%%%%%%%%%

%%%%%%%%%%Covariance Update

Pnew = Pold + Cptp'*inv(RPTP)*Cptp;
if isnan(Pnew(1,1)) || isinf(Pnew(1,1))
  Pnew = zeros(Numptp,Numptp);
end

%%Deconstruct Covariance Matrix

pvectorPTP = zeros(Numptp,1);
loc = 1;
for jj = 1:Numptp
  mark = Numptp+1-jj;
  vec = diag(Pnew([1:mark],[jj:Numptp]));
  pvectorPTP(loc:loc+length(vec)-1) = vec;
  loc = loc + length(vec);
end

%%%%%%%%%%%%


  
