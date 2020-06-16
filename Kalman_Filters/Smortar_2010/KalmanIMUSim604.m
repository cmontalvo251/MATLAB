%%3DOF Kalman Filter with Sensor and Model Noise
%%Developed by Carlos Montalvo
clear
clc
close all

global GPSupdatecounter Statesmeasured Pnew C R xold
global NumKalman MASSESTIMATE Sestimate rho_error sosound_error drag_error
global CONFIG ATMOS PROJ BODYAERO CAN RAP FCS TIMESIM DISANALY
global XBODY SIGMA PSIWIND SOS RHO D IP TOMACH NMB
global TOSLCOP TOBLCOP TOWLCOP TOSLMAG TOBLMAG TOWLMAG
global TOSLMAGA2 TOBLMAGA2 TOWLMAGA2
global TOSLMAGA4 TOBLMAGA4 TOWLMAGA4
global T TFINAL DT NumMAG Numptp
global TOCX0 TOCX2 TOCNA1 TOCNA3 TOCNGAMA3 TOCY0 TOCZ0
global TOCYPA TOCLP TOCLDD TOCLGAMA2 TOCMQ TOCMQA2
global NBODYFINS SLCG BLCG WLCG WEIGHT
global IXX IYY IZZ IXZ IYZ IXY IXXI IYYI IZZI
global IXYI IXZI IYZI pqrold ptpold
global XBODYFORCE YBODYFORCE ZBODYFORCE
global LBODYMOMENT MBODYMOMENT NBODYMOMENT
global XFORCE YFORCE ZFORCE xold GRAVITY
global LinearPlant GPSupdate dCxdM ptpmeasured
global ptpnew pqrnew pvectorPTP RPTP LinearPTP
global ptpNOMAGnew ptpNOMAGold
global magmeasured magderivfiltered MAGupdatecounter

%%GRAVITATIONAL CONSTANT%%%%%%%%%%%%%%%

GRAVITY = 32.2;

%%%%%%%%%%%%%%%Define Input Files%%%%%%%%%%%%%%

if exist('xactual','var')
  ALREADYLOADED = 1;
else
  ALREADYLOADED = 0;
end

%%%%Projectile Root Directory%%%%%

projectile = 'Navy_Army_Finner/';
projectile = 'Smortar/';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

COMP = 1; %%0 = windows home machine 1 = Linux Office Comp 2 =
          %Linux home machine
if COMP == 1
   disp('Using Linux Office Machine')
   disp(['Projectile = ',projectile])
   IFILESPATH = ['//home/carlos/Georgia_Tech/ARL/Kalman_Filter/Input_Files/',projectile];
   %%%Path of Senor Suite
   addpath '//home/carlos/Georgia_Tech/ARL/Kalman_Filter/MATLAB/Sensor_Suite/';
elseif COMP == 0
   disp('Using Windows Home Machine')
   IFILESPATH = ['c:\Root\Georgia_Tech\ARL\Kalman_Filter\Input_Files\',projectile];
   addpath 'c:\Root\Georgia_Tech\ARL\Kalman_Filter\Sensor_Suite\';
elseif COMP == 2
  disp('Using Linux Home Machine')
  IFILESPATH = ['/media/SW_Preload/Root/Georgia_Tech/ARL/Kalman_Filter/Input_Files/',projectile];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%Input File Names%%%%%%%%%%%%

states = [IFILESPATH 'Smortar_BODY.out'];
derivs = [IFILESPATH 'Smortar_BODYDOT.out'];
%states = [IFILESPATH 'ANFinner_BODY.out'];
%derivs = [IFILESPATH 'ANFinner_BODYDOT.out'];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%ADMIN FLAGS%%%%%%%%%%%%%%%

ESTIMATOR = 0; %%Kalman Filter(Position Updates)
IMU = 0; %%IMU
MAGNETOMETER = 0; %%Magnetometer
ACCELEROMETER = 0; %%Turn accelerometer on or off
GPSMEASUREMENTS = 0; %%Turn GPS measurements on or off
IMUMEASUREMENTS = 0; %%Turn IMU measurements on or off
QUANT = 0; %%Quantize elements
NOISETYPE = 0; %%sensor errors %%0 = off 1 = white noise 2 = all types of errors turned on
ERRORS = 0; %%turn projectile property errors on or off
NUMFILES = 2; %%how many imput files are there? (i.e. one file with
              %everything or 2 files with the derivatives in one
              %and the states in another
UNITS = 2; %%1 for english and 2 for SI
UNITS2 = 2; %%1 for rad and 2 for deg

%%%%%%%%%%%%%%%%PLOT FLAGS%%%%%%%%%%

PLOT3D = 0; %%3d plot of trajectory
POSITION = 0; %%x,y,z
VELOCITY = 0; %%u,v,w
ATTITUDE = 0; %%phi,theta,psi
PHIZOOM = 0; %%zoomed in phi plot
RATES = 0; %p,q,r
AERO1 = 0; %%wind stuff u,v,w wind
AERO2 = 0; %%more wind stuff
EXTRA = 0; %%density and Cxo
XYZDERIVS = 0; %xdot,ydot,zdot
UVWDERIVS = 0;
PTSDERIVS = 0;
MAG = 0; %%Magnetometer
ACCEL = 0; %%Accelerometer


%%%%%%QUANTIZATION PARAMETERS%%%%%%%%%%

numtype = 2; %%0 = floating point, 1 = fixed point, 2 = dynamic range
ABITS = 12; %%number of bits before the decimal(fixed)
EBITS = 12; %%number of bits after the decimal(fixed)
BITS = ABITS; %%%refer to Quantsim Help for more information
%%For floating Point ABITS = number of bits for the mantissa
%%and EBITS = the number of bits for the exponent
%%%y = a(mantissa)*2^Xi(exponent)

%%Dynamic Ranges
rangeMAG = [-0.02 0.7];
rangeACCEL = [-7 2.1].*GRAVITY;
rangeGPS = [-40 3000].*3.28;
rangePQR = [-1 1];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if IMU
  %MAGNETOMETER = 1;
  IMUMEASUREMENTS = 1;
end
if ESTIMATOR
  GPSMEASUREMENTS = 1;
end
if IMUMEASUREMENTS || GPSMEASUREMENTS
  MEASUREMENTS = 1;
else
  MEASUREMENTS = 0;
end


%%%%%%%%%%%%%DEFINE STATE ESTIMATOR PARAMETERS%%%%%%

NumKalman = 6; %%N = number of states in kalman filter - pvector (x,y,z,xdot,ydot,zdot)
NumObservedStates = 6; %%y = Cx. observed states are x,y,z,xdot,ydot,zdot thus C is 6 by 6
NumMAG = 6; %%number of magnetometer measurements
Numptp = 3; %%number of attitude parameters to estimate measurements
%%Define C matrix or output matrix
C = [eye(NumObservedStates) zeros(NumObservedStates,NumKalman-NumObservedStates)];

%%%%%%%%%%%%%%SENSOR NOISE%%%%%%%%%%%%%%%%%%%%

%%%Sensor noise. If you think that your sensors are
%%terrible you should make this gain very large.
%%This is a guess at the expected value of the
%%measurement noise
r1 = 2.8;r2 = 2.8+100;r3 = 6.2+10;r4 = 2.20;r5 = 2.20+100;r6 = 5;
%%note that r1 is the guess at the amount of noise in x, r2 is the
%noise in y, etc etc
%r7 = 0;r8 = 0;r9 = 0;
%%size(R) = NumObserved x NumObserved
rr = [r1 r2 r3 r4 r5 r6];
%rr = 1*ones(1,NumObservedStates);
R = diag(rr);

%Sensor Noise Estimates of mx,my,mz and derivatives

r1PTP = 1;r2PTP = 1;r3PTP = 1;
r4PTP = 1;r5PTP = 1;r6PTP = 1;
rrPTP = ([r1PTP r2PTP r3PTP r4PTP r5PTP r6PTP]);
%rrPTP = 1*ones(1,6);
RPTP = diag([rrPTP(1:NumMAG)]);

%%%%%%%COVARIANCE MATRIX%%%%%%%%%%%%%%%%%%%%

%%Initial Covariance Conditions
%%This is your initial guess at the %error in the system
% if NumKalman = 12, you need 78 p's or just use sum(N:-1:1);
%pvector = [p1;p2;p3;p4;p5;p6;p7;p8;p9;p10;p11;p12;p13;p14;p15;p16;p17;p18;p19;p20;p21];
numelP = sum(NumKalman:-1:1);
pvector = 1*ones(numelP,1);
numelPTP = sum(Numptp:-1:1);
pvectorPTP = 0*ones(numelPTP,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%Read Boom.ifiles%%%%%%%%%%%%%%%%

%disp( ['BOOM IFILES PATH: ',IFILESPATH]);
if ~exist([IFILESPATH,'Boom.ifiles'])
  disp([IFILESPATH,'Boom.ifiles'])
  return
end
fid = fopen([IFILESPATH,'Boom.ifiles']);
CONFIG = [IFILESPATH,fgetl(fid)];
ATMOS = [IFILESPATH,fgetl(fid)];
PROJ = [IFILESPATH,fgetl(fid)];
BODYAERO = [IFILESPATH,fgetl(fid)];
CAN = [IFILESPATH,fgetl(fid)];
RAP = [IFILESPATH,fgetl(fid)];
FCS = [IFILESPATH,fgetl(fid)];
TIMESIM = [IFILESPATH,fgetl(fid)];
DISANALY = [IFILESPATH,fgetl(fid)];
BODYSIMOUT = [IFILESPATH,fgetl(fid)];
BODYSIMDOT = [IFILESPATH,fgetl(fid)];
FCSSIMOUT = [IFILESPATH,fgetl(fid)];
MISCSIMOUT = [IFILESPATH,fgetl(fid)];
DISOUT = [IFILESPATH,fgetl(fid)];
RUNLOG = [IFILESPATH,fgetl(fid)];
fclose(fid);

%%%%%%%%%%%%%LOAD INPUT FILES%%%%%%%%%%%%%%%%%%

if ~ALREADYLOADED

  BoomLoad
  %%Using Loaded Values Calculate dCxdM
  dCxdM = zeros(length(TOMACH),1);
  for i = 2:length(TOMACH)
    dCxdM(i) = (TOCX0(i) - TOCX0(i-1))/(TOMACH(i) - TOMACH(i-1));
  end
  dCxdM(1) = dCxdM(2);
  MASS = WEIGHT/GRAVITY;
  Sref = D^2/8;

  %%%%%%%%%%%Import Trajectory Data
if NUMFILES == 2
disp('Importing States')
if ~exist(states)
  disp(['This file does not exist->',states])
  return
end
Body = dlmread(states);
disp('States Loaded')
tactual = Body(:,1)'; 
xactual = Body(:,2)';
yactual = Body(:,3)';
zactual = Body(:,4)';
q0 = Body(:,5)'; %%Attitudes
q1 = Body(:,6)';
q2 = Body(:,7)';
q3 = Body(:,8)';

%%%%%%%%%%Calculate Phi,theta,psi%%%%%%%%%%%%

phiactual = atan2(2.*(q0.*q1 + q2.*q3),1-2.*(q1.^2 + q2.^2));
thetaactual = asin(2.*(q0.*q2-q3.*q1));
psiactual = atan2(2.*(q0.*q3 + q1.*q2),1-2.*(q2.^2 + q3.^2));

uactual = Body(:,9)'; %%Velocity
vactual = Body(:,10)';
wactual = Body(:,11)';
rhoactual = zeros(length(uactual),1);
Cxactual = zeros(length(uactual),1);

%%%%Calculate Density and Cx %%%%%%%%%%%%%%%%

disp('Calculating rho and Cxactual')
for i = 1:length(uactual)
    Vtotal = sqrt(uactual(i)^2 + vactual(i)^2 + wactual(i)^2);
    rho = 0.0023784722*(1+0.0000068789*zactual(i))^4.258;
    sos = 49.0124*sqrt(518.4+0.003566*zactual(i));
    M = Vtotal/sos;
    if M <= TOMACH(1)
       Cx = TOCX0(1);
    elseif M >= TOMACH(end)
       Cx = TOCX0(end);
    else
      loc = find(M < TOMACH,1);
      slope = (TOCX0(loc) - TOCX0(loc-1))/(TOMACH(loc)-TOMACH(loc-1));
      Cx = TOCX0(loc-1) + slope*(M-TOMACH(loc-1));
    end
    rhoactual(i) = rho;
    Cxactual(i) = Cx;
end
disp('Calculated rho and Cx actual')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pactual = Body(:,12)';
qactual = Body(:,13)';
ractual = Body(:,14)'; %%%Body Rates
%uwindactual = ones(1,length(qactual))*SIGMA*0.6366197723*cos(PSIWIND);
%vwindactual = ones(1,length(qactual))*SIGMA*0.6366197723*sin(PSIWIND);
%wwindactual = zeros(1,length(qactual));

%%%%%%IMPORT DERIVATIVES%%%%%%%%%%%%%%%%%%

disp('Importing Derivatives')
Body = dlmread(derivs);
disp('Derivatives Loaded')
tdotactual = Body(:,1)';
xdotactual = Body(:,2)';
ydotactual = Body(:,3)';
zdotactual = Body(:,4)';
q0dot = Body(:,5)'; %%Attitudes
q1dot = Body(:,6)';
q2dot = Body(:,7)';
q3dot = Body(:,8)';
udotactual = Body(:,9)'; %%Velocity
vdotactual = Body(:,10)';
wdotactual = Body(:,11)';
pdotactual = Body(:,12)';
qdotactual = Body(:,13)';
rdotactual = Body(:,14)'; %%%Body Rates
clear Body
return

elseif NUMFILES == 1

%%%%%%%%%%%Import Trajectory Data%%%%%%%%%

disp('Importing States')
if ~exist(states)
  disp(states)
  return
end
Body = dlmread(states);
disp('States Loaded')
tactual = Body(:,1)'; 
xactual = Body(:,2)';
yactual = Body(:,3)';
zactual = Body(:,4)';
q0 = Body(:,5)'; %%Attitudes
q1 = Body(:,6)';
q2 = Body(:,7)';
q3 = Body(:,8)';

%%%%%%%%%%Calculate Phi,theta,psi%%%%%%%%%%%

phiactual = atan2(2.*(q0.*q1 + q2.*q3),1-2.*(q1.^2 + q2.^2));
thetaactual = asin(2.*(q0.*q2-q3.*q1));
psiactual = atan2(2.*(q0.*q3 + q1.*q2),1-2.*(q2.^2 + q3.^2));

uactual = Body(:,9)'; %%Velocity
vactual = Body(:,10)';
wactual = Body(:,11)';
rhoactual = zeros(length(uactual),1);
Cxactual = zeros(length(uactual),1);

%%%%Calculate Density and Cx%%%%%%%%%%%%%%%%

disp('Calculating rho and Cxactual')
for i = 1:length(uactual)
    Vtotal = sqrt(uactual(i)^2 + vactual(i)^2 + wactual(i)^2);
    rho = 0.0023784722*(1+0.0000068789*zactual(i))^4.258;
    sos = 49.0124*sqrt(518.4+0.003566*zactual(i));
    M = Vtotal/sos;
    if M <= TOMACH(1)
       Cx = TOCX0(1);
    elseif M >= TOMACH(end)
       Cx = TOCX0(end);
    else
      loc = find(M < TOMACH,1);
      slope = (TOCX0(loc) - TOCX0(loc-1))/(TOMACH(loc)-TOMACH(loc-1));
      Cx = TOCX0(loc-1) + slope*(M-TOMACH(loc-1));
    end
    rhoactual(i) = rho;
    Cxactual(i) = Cx;
end
disp('Calculated rho and Cx actual')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pactual = Body(:,12)';
qactual = Body(:,13)';
ractual = Body(:,14)'; %%%Body Rates
%uwindactual = ones(1,length(qactual))*SIGMA*0.6366197723*cos(PSIWIND);
%vwindactual = ones(1,length(qactual))*SIGMA*0.6366197723*sin(PSIWIND);
%wwindactual = zeros(1,length(qactual));

xdotactual = Body(:,20)';
ydotactual = Body(:,21)';
zdotactual = Body(:,22)';
q0dot = Body(:,23)'; %%Attitudes
q1dot = Body(:,24)';
q2dot = Body(:,25)';
q3dot = Body(:,26)';
udotactual = Body(:,27)'; %%Velocity
vdotactual = Body(:,28)';
wdotactual = Body(:,29)';
pdotactual = Body(:,30)';
qdotactual = Body(:,31)';
rdotactual = Body(:,32)'; %%%Body Rates
clear Body
return
else
  disp('NUMFILES is incorrect')
  return
end %%End Numfiles Cases

else
  disp('Everything loaded already')
  if ESTIMATOR && IMU
    disp('Kalman Filter and IMU On')
    estimatorname = 'Kalman Filter and IMU';
  elseif ESTIMATOR && ~IMU
    disp('Kalman Filter Only')
    estimatorname = 'Kalman Filter';
  elseif ~ESTIMATOR && IMU
    disp('IMU Only')
    estimatorname = 'IMU';
  end
end %%loading data

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%ADD ERRORS IN CONSTANTS SUCH AS REFERECE AREA

if ESTIMATOR
   rhoactualSL = 0.0023784722;
  if ~ERRORS
    mass_error = 0;
    reference_error = 0;
    drag_error = 0;
    rho_error = 0;
    sosound_error = 0;
  else
    mass_error = -(MASS*0.02) + (MASS*0.02)*rand(1,1);
    reference_error = -(Sref*0.01) + (Sref*0.01)*rand(1,1);
    drag_error = -(0.2*0.03) + (0.2*0.03)*rand(1,1);
    rho_error = -(rhoactualSL*0.02) + (rhoactualSL*0.02)*rand(1,1);
    sosound_error = -1115.5*0.02 + (1115.5*0.02)*rand(1,1);
  end
  rhoestimate0 = rho_error + rhoactualSL;
  sosoundestimate = 1115.5 + sosound_error;
  MASSESTIMATE = MASS + mass_error;
  Sestimate = Sref + reference_error;
end

if ACCELEROMETER
  r1 = 0;
  r2 = 0;
  r3 = 0;
  RCGtoAactual = [r1;r2;r3];
  if ~ERRORS
    r1_error = 0;
    r2_error = 0;
    r3_error = 0;
  else
    r1_error = randn*0.01;
    r2_error = randn*0.01;
    r3_error = randn*0.01;
  end
  r1estimate = r1 + r1_error;
  r2estimate = r2 + r2_error;
  r3estimate = r3 + r3_error;
  RCGtoAestimate = [r1estimate;r2estimate;r3estimate];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%UPDATE FREQUENCIES%%%%%%%%%%%%%%

GPSfreq = 10; %Hz
GPSupdate = 1/GPSfreq; %%measure every GPSupdate seconds
PQRfreq = 1000; %Hz
PQRupdate = 1/PQRfreq; %%measure every PQRupdate seconds
MAGfreq = 10; %Hz
MAGupdate = 1/MAGfreq; %%measure every MAGupdate seconds

%%%List of Frequencies

%Smortar_BODY_NOWIND.out - 1e-4 secs @ 10kHz
%ANFinner_BODY.out - 1e-4 secs @ 10 kHz

%Keep in mind that DT integration rates must be smaller than
%GPSupdate or PQRupdate

%%%%%%%%TIME STEP%%%%%%%%%%%%%%%%%%%

DT = tactual(2);
DT = 0.001;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (GPSupdate < DT) || (PQRupdate < DT) || (MAGupdate < DT)
  disp('Update Rates are faster than integration')
  GPSupdate
  PQRupdate
  MAGupdate
  DT
  return
end

if (GPSupdate < tactual(2)) || (PQRupdate < tactual(2)) || (MAGupdate<tactual(2))
  disp('Update Rates are faster than saved simulation')
  disp([states,[' <- this file must be recreated using a smaller' ...
		' time step']])
  disp(['DT = ',num2str(tactual(2))])
  return
end

%%%%%%%%%Generate Magnetometer Data and ACCEL Regardless of noisetype

if MAGNETOMETER

  disp('Generating Magnetometer Data')
  [loc magmeasured MAGpure MAGdotpure tmeasuredMAG] = MAGsim(phiactual,thetaactual,psiactual,NOISETYPE,MAGupdate,tactual,pactual,qactual,ractual);
  if QUANT
    magmeasured = QUANTsim(magmeasured,numtype,BITS,rangeMAG);
  end
  ptpmeasured = zeros(3,length(tmeasuredMAG));
  disp('Generated Magnetometer Data')

  %%%%%%%Derivative of MAGNETOMETER%%%%%%%%

  disp('Generating Derivative of Magnetometer')
  [r,c] = size(magmeasured);
  magderiv = magmeasured;
  wc1 = 1; %%Cutoff frequency for derivative-low-pass filter
  tau1 = 1/wc1;
  wc2 = 100; %%Cuttoff frequency for low-pass filter
  tau2 = 1/wc2;
  T = MAGupdate;   %%Sampling Time
  if c == 1
    magderiv(:,1) = 0;
  else
    magderiv(:,1) = (magmeasured(:,2)-magmeasured(:,1))./T;
    magderiv(:,1) = 0;
  end
  magfiltered = magderiv;
  magderivfiltered = magfiltered;
  for i = 1:c-1
    %%Filter Magnetometer Through a Derivative-Low Pass Filter

    magderiv(:,i+1) = (2.*(magmeasured(:,i+1)-magmeasured(:,i))+magderiv(:,i).*(2*tau1-T))./(2*tau1+T);

    %%Quantize the Element
    if QUANT
      magderiv(:,i+1) = QUANTsim(magderiv(:,i+1),numtype,BITS,rangeMAG);
    end

    %%Filter Derivative of Magnetometer Through a Low Pass Filter

    %magderivfiltered(:,i+1) = (magderiv(:,i+1)+magderiv(:,i)-magfiltered(:,i).*(1-2*tau2/T))./(2*tau2/T+1);

    %%OR just leave it alone

    magderivfiltered(1,i+1) = magderiv(1,i+1);
    magderivfiltered(2,i+1) = magderiv(2,i+1);
    magderivfiltered(3,i+1) = magderiv(3,i+1);

  end
  disp('Generated Magnetometer Derivative')

  %%What if Magdot had no errors in it but magxyz did.
  %magderivfiltered = MAGdotpure(:,loc);
  %magmeasured = MAGpure(:,loc);

end

if ACCELEROMETER
  disp('Generating Accelerometer Data')
  ACCELpure = ACCELsim([udotactual;vdotactual;wdotactual],[pactual;qactual;ractual],[uactual;vactual;wactual],[phiactual;thetaactual;psiactual],[pdotactual;qdotactual;rdotactual],RCGtoAactual,0,GRAVITY);
  if NOISETYPE~=0
     ACCELout = ACCELsim([udotactual;vdotactual;wdotactual],[pactual;qactual;ractual],[uactual;vactual;wactual],[phiactual;thetaactual;psiactual],[pdotactual;qdotactual;rdotactual],RCGtoAestimate,NOISETYPE,GRAVITY);
  else
     ACCELout = ACCELpure;
  end
  if QUANT
    ACCELout = QUANTsim(ACCELout,numtype,BITS,rangeACCEL);
  end
  disp('Generated Accelerometer Data')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if MEASUREMENTS || ESTIMATOR

   %%%%%%%%%%ADD GPS, Rate GYRO and MAGNETOMETER ERRORS%%%%%%%%%%%%

   %%Use GPSsim to simulate GPS errors(GPS measures Position and
   %Position Derivatives)
   XYZin = [xactual;yactual;zactual];
   XYZdotin = [xdotactual;ydotactual;zdotactual];
   GPSin = [XYZin;XYZdotin];
   %%Use PQRsim to simulate Rate Gyro Errors
   PQRin = [pactual;qactual;ractual];
   %%Pitot Tubes measures VBody + Vwind
   %WINDin = [uactual;vactual;wactual] + [uwindactual;vwindactual;wwindactual];
   %[r,c] = size(XYZin);
   %%Generate State Errors

   if NOISETYPE ~= 0
      if ESTIMATOR || GPSMEASUREMENTS
	disp('Adding GPS Sensor Errors')
	GPS = GPSsim(GPSin,NOISETYPE);
	disp('GPS Sensor Errors Added')
      end
      if IMU || IMUMEASUREMENTS
	 disp('Generating Rate Gyro Data')
	 PQR = PQRsim(PQRin,NOISETYPE);
	 disp('Rate Gyro Sensor Generated')
      end
   else
      GPS = GPSin;
      PQR = PQRin;
   end
   if QUANT && (ESTIMATOR || GPSMEASUREMENTS)
     GPS = QUANTsim(GPS,numtype,BITS,rangeGPS);
   end
   if QUANT && (IMU || IMUMEASUREMENTS)
     PQR = QUANTsim(PQR,numtype,BITS,rangePQR);
   end

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

   %XYZdotpolluted = GPS(4:6,:);
   %%Pitot Tube measures UVW + WIND thus to back out WIND
   %%We need UVW with errors and the actual WIND data
   %WIND = WINDsim(WINDin,XYZdotpolluted,NOISETYPE);

   %%%%%%%%%%%%%%%UNWRAP MEASUREMENTS%%%%%%%%%%%%%%
   
   if GPSMEASUREMENTS
     XYZmeasured = GPS(1:3,:);
     XYZdotmeasured = GPS(4:6,:);
     measurelength = length(XYZmeasured);
   end
   if IMUMEASUREMENTS
     PQRmeasured = PQR;
     measurelength = length(PQRmeasured);
   end
   
   %%%%%%%%%%GET MEASURED DATA AT UPDATE FREQUENCY%%%%%%%%%%%%%%%%%
   
   disp('Allocating Memory for Measurements')
   if GPSMEASUREMENTS
     Statesmeasured = zeros(NumObservedStates,floor(tactual(end)/GPSupdate+1));
     tmeasuredGPS = zeros(1,floor(tactual(end)/GPSupdate+1));
   end
   if IMUMEASUREMENTS
     tmeasuredPQR = zeros(1,floor(tactual(end)/PQRupdate+1));
     pqrmeasured = zeros(3,floor(tactual(end)/PQRupdate+1));
   end
   disp('Memory Allocated for Measurements')
   GPSupdatetime = 0;
   PQRupdatetime = 0;
   GPScounter = 1;
   PQRcounter = 1;
   if MEASUREMENTS
     disp('Taking Measurements at Update Frequency')
     for i = 1:measurelength
       if (tactual(i) >= GPSupdatetime) && GPSMEASUREMENTS
	 %%Save Measurments
	 Statesmeasured(:,GPScounter) = [XYZmeasured(:,i);XYZdotmeasured(:,i)];
	 tmeasuredGPS(GPScounter) = tactual(i);
	 %%increment updatetime and counter
	 GPSupdatetime = GPSupdatetime + GPSupdate;
	 GPScounter = GPScounter + 1;
       end
       if (tactual(i) >= PQRupdatetime - 1e-8) && IMUMEASUREMENTS
	 pqrmeasured(:,PQRcounter) = PQRmeasured(:,i);
	 PQRupdatetime = PQRupdatetime + PQRupdate;
	 tmeasuredPQR(PQRcounter) = tactual(i);
	 PQRcounter = PQRcounter + 1;
       end
     end
     disp('Measurements Taken')
   end
end %%End MEASUREMENT || ESTIMATOR || IMU

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ESTIMATOR || IMU %%Run Kalman Filter or IMU
TFINAL = tactual(end);
%%State Estimation Memory Allocation
disp('Allocating Memory for Integration')
number = 1;
l = TFINAL/DT+number;
if ESTIMATOR
  xestimate = ones(1,l);
  yestimate = ones(1,l);
  zestimate = ones(1,l);
  xdotestimate = ones(1,l);
  ydotestimate = ones(1,l);
  zdotestimate = ones(1,l);
  rhoestimate = ones(1,l);
  Cxestimate = ones(1,l);
end
if IMU
  phiestimate = ones(1,l);
  thetaestimate = ones(1,l);
  psiestimate = ones(1,l);
  phiNOMAGestimate = ones(1,l);
  thetaNOMAGestimate = ones(1,l);
  psiNOMAGestimate = ones(1,l);
  pestimate = ones(1,l);
  qestimate = ones(1,l);
  restimate = ones(1,l);
  mxbestimate = ones(1,l);
  mybestimate = ones(1,l);
  mzbestimate = ones(1,l);
  mxbdotestimate = ones(1,l);
  mybdotestimate = ones(1,l);
  mzbdotestimate = ones(1,l);
end
testimate = 0:DT:TFINAL;
disp('Memory Allocated for Integration')

if ESTIMATOR
  
%Initial condition of estimated rho

rho = rhoestimate0;

%Initial condition of estimated Cx

V = sqrt(sum(XYZdotmeasured(:,1).^2));
M = V/sosoundestimate;
Cx = ((interp1(TOMACH,TOCX0,M))+drag_error);

%%Use measured states for initial conditions

xold = [XYZmeasured(:,1);XYZdotmeasured(:,1);rho;Cx;pvector];
xnew = xold;

%%Initial Linear Plant for x,y,z,xdot,ydot,zdot

LinearPlant = CalculateLinearPlant();

end

if IMU
  pqr = pqrmeasured(:,1);
  pqrnew = pqr;
  pqrold = pqrnew;
  if ERRORS
    attitudeerror = 0.1;
  else
    attitudeerror = 0;
  end
  phi = phiactual(1) + attitudeerror*phiactual(1)*rand;
  theta = thetaactual(1) + attitudeerror*thetaactual(1)*rand;
  psi = psiactual(1) + attitudeerror*psiactual(1)*rand;
  ptpnew = [phi;theta;psi];
  ptpold = ptpnew;
  ptpNOMAGnew = ptpold;
  ptpNOMAGold = ptpNOMAGnew;
  ptpmeasured(:,1) = ptpold;
  if MAGNETOMETER
    magdata = magmeasured(:,1); 
    magderivdata = magderivfiltered(:,1);
  end
  
  %%%Initialize The Linear Phi,theta,psi matrix
  
  LinearPTP = CalculateLinearPTP();
  
end

%%%%%%%%%%%INTEGRATION USING KALMAN FILTER and IMU%%%%%%%%%%%%%%%

T = 0;tstart = 0;
threshold = 0;
GPSupdatecounter = 2;
PQRupdatecounter = 2;
MAGupdatecounter = 2;
pqrupdatetime = PQRupdate;
magupdatetime = MAGupdate;
nextout = 5;
rk4const = [0.5 0.5 1 1];
timeconst = [0 1/2 1/2 1];
rk4step = [1 2 2 1];
i = 1;
while T < TFINAL+1e-8

  %%%%%%Update States and Linear Plant Using Measurements%%%%%%%%%%%
    
    if ESTIMATOR && (T > (tstart + GPSupdate - 1e-8)) 
      UpdateStateVector();
      LinearPlant = CalculateLinearPlant();
      tstart = T;
    end
    
    if IMU && T >= (pqrupdatetime-1e-8)
      pqrnew = pqrmeasured(:,PQRupdatecounter);
      PQRupdatecounter = PQRupdatecounter + 1;
      pqrupdatetime = pqrupdatetime + PQRupdate;
    end
    
    if MAGNETOMETER && T >= (magupdatetime-1e-8)
      magdata = magmeasured(:,MAGupdatecounter);
      magderivdata = magderivfiltered(:,MAGupdatecounter);
      UpdateAttitudeVector();
      LinearPTP = CalculateLinearPTP();
      magupdatetime = magupdatetime + MAGupdate;
    end
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  %%%%%Notify User of Progress%%%%%%%%%%

     counter = T/TFINAL*100;
    if (counter >= threshold) %%only output every time the counter changes one second
      disp(['Running ',estimatorname,': ',num2str(floor(counter)),' % Complete']);
      threshold= threshold + nextout;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%Save States%%%%%%%%%%

    if ESTIMATOR
      xold = xnew;
      xestimate(i) = xold(1);
      yestimate(i) = xold(2);
      zestimate(i) = xold(3);
      xdotestimate(i) = xold(4);
      ydotestimate(i) = xold(5);
      zdotestimate(i) = xold(6);
      rhoestimate(i) = xold(7);
      Cxestimate(i) = xold(8);
    end
    
    if IMU
      pqrold = pqrnew;
      ptpold = ptpnew;
      ptpNOMAGold = ptpNOMAGnew;
      phiestimate(i) = ptpold(1);
      thetaestimate(i) = ptpold(2);
      psiestimate(i) = ptpold(3);
      phiNOMAGestimate(i) = ptpNOMAGold(1);
      thetaNOMAGestimate(i) = ptpNOMAGold(2);
      psiNOMAGestimate(i) = ptpNOMAGold(3);
      pestimate(i) = pqrold(1);
      qestimate(i) = pqrold(2);
      restimate(i) = pqrold(3);
    end
    if MAGNETOMETER
      mxbestimate(i) = magdata(1);
      mybestimate(i) = magdata(2);
      mzbestimate(i) = magdata(3);
      mxbdotestimate(i) = magderivdata(1);
      mybdotestimate(i) = magderivdata(2);
      mzbdotestimate(i) = magderivdata(3);
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%3DOF and IMU INTEGRATION%%%%%%%%%%%%%%
    
    if ESTIMATOR
        xdotRK4 = zeros(NumKalman+length(pvector),1);
	x = xold;
    end
    if IMU 
      ptpdotRK4 = [0;0;0];
      ptpNOMAGdotRK4 = [0;0;0];
      pPTPdotRK4 = zeros(numelPTP,1);
      pqr = pqrold;
      ptp = ptpold;
      ptpNOMAG = ptpNOMAGold;
      pPTP = pvectorPTP;
    end
    
    for j = 1:4
      if ESTIMATOR
	xdot = StateEstimation(T,x,0);
	TNOM = T + timeconst(j)*DT;
	x = x + xdot*rk4const(j)*DT;
	xdotRK4 = xdotRK4 + (1/6)*rk4step(j)*xdot;
      end
      if IMU
	[ptpdot ptpdotNOMAG pvectorPTPdot] = IMUEstimation(T,ptp,ptpNOMAG,pPTP,pqr);
	pPTP = pPTP + pvectorPTPdot*rk4const(j)*DT;
	ptp = ptp + ptpdot*rk4const(j)*DT;
	ptpNOMAG = ptpNOMAG + ptpdotNOMAG*rk4const(j)*DT;
	ptpdotRK4 = ptpdotRK4 + (1/6)*rk4step(j)*ptpdot;
	ptpNOMAGdotRK4 = ptpNOMAGdotRK4 + (1/6)*rk4step(j)*ptpdotNOMAG;
	pPTPdotRK4 = pPTPdotRK4 + (1/6)*rk4step(j)*pvectorPTPdot;
      end
    end
    
    %%%%%% Step States %%%%%%%%%%%%%%%%%%%%%
    
    if ESTIMATOR
      xnew = xold + (DT*xdotRK4);
    end
    if IMU
      ptpnew = ptpold + DT*ptpdotRK4;
      pvectorPTP = pvectorPTP + DT*pPTPdotRK4;
      ptpNOMAGnew = ptpNOMAGold + DT*ptpNOMAGdotRK4;
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%Increment%%%%%%%%%%

    i = i + 1;
    T = T + DT;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%
    
end %%for Loop of entire simulation

disp('State Estimation Finished')
end %%ESTIMATOR or IMU

PlotRoutine

toc