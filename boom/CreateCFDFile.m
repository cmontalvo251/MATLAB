%%This will create the CFD OUT FILE
OUTPUTFILENAME = 'MT.CFD';
DIAMETER = 0.083;
NUMBEROFFINS = 0;
MACH = [0 0.5 0.65 0.8];
BLCOP = zeros(length(MACH),1);
WLCOP = BLCOP;
SLMAG = WLCOP;
BLMAG = WLCOP;
WLMAG = WLCOP;
SLMAGA2 = WLCOP;
BLMAGA2 = WLCOP;
WLMAGA2 = WLCOP;
SLMAGA4 = WLCOP;
BLMAGA4 = WLCOP;
WLMAGA4 = WLCOP;
CNA3 = WLCOP;
CNGAMA3 = WLCOP;
CY0 = WLCOP;
CZ0 = WLCOP;
CYPA = WLCOP;
CMQA2 = WLCOP;

%%Define Variables
%Actual
SLCOP = [0.158129392753411;
0.158129392753411;
0.14450679659472;
0.14450679659472];
CX0 = [0.508424590163934;
0.508424590163934;
0.534986301369863;
0.534986301369863];
CX2 = [5.77181936129115;
5.77181936129115;
6.85623100189952;
6.85623100189952];
CNA = [4.5381098778987;
4.5381098778987;
4.49313269098092;
4.49313269098092];
CNA3 = [26.7245889773819;
26.7245889773819;
20.376519454895;
20.376519454895];
CLP = [-6.514;
-6.514;
-6.790;
-6.790];
CLDD = [0.12;
0.12;
0.08;
0.08];
CMQ = [-150;
-150;
-150;
-150];
%%Define CANARDS
ICANARDS = 1;
NCANARDS = 4;
S = (pi*DIAMETER^2)/4;
SCAN = [S S S S];
SLCAN = [0.318 0.318 0.318 0.318];
CPROC = 0.06225;
PHICAN = [0 pi/2 pi -pi/2];
BLCAN = CPROC.*cos(PHICAN);
WLCAN = CPROC.*sin(PHICAN);
GAMCAN = [0 0 0 0];
DELTACAN = [0 0 0 0];
MACHCAN = MACH;
NMACHCAN = length(MACHCAN);
TOCL1CAN = [0.897236414141156;
0.897236414141156;
0.897236414141156;
0.897236414141156];
TOCL3CAN = [10.6686148355956;
10.6686148355956;
10.6686148355956;
10.6686148355956];
TOCL5CAN = [-423.314272882367;
-423.314272882367;
-423.314272882367;
-423.314272882367];
TOCD0CAN = [0.00188049223692509;
0.00188049223692509;
0.00188049223692509;
0.00188049223692509];
TOCD2CAN = [0 0 0 0];
TOCICAN = 0.*MACHCAN;

fid = fopen(OUTPUTFILENAME,'w');
if fid == -1
  disp('File Cannot be created')
  disp(OUTPUTFILENAME)
  return
end

fprintf(fid,'%s \n', '  0.000000     ! atmospheric wind intensity (m/s), VMEANWIND  ');
fprintf(fid,'%s \n', '   0.000000     ! atmospheric wind azimuthal angle (rad), PSIWIND  ');
fprintf(fid,'%s \n', '   0            ! atmospheric density flag (0=constant,1=eqn,2=table)');
fprintf(fid,'%s \n', '   1.225     ! air density (kg/m^3), RHO ');
fprintf(fid,'%s \n', '  340.29      ! speed of sound (m/s), SOS');
fprintf(fid,'%s \n', '     1             ! body aerodynamic flag, (0=off,1=on)');
fprintf(fid,'%15.10e %s \n',DIAMETER,' ! Reference Diameter for Aerodynamic Loads (m)');
fprintf(fid,'%15.10e %s \n',NUMBEROFFINS,' ! Number of Body Fins (nd)');
fprintf(fid,'%15.10e %s \n',max(size(MACH)),' ! Number of Mach Number Points (nd)');

fprintf(fid,'%15.10e %s \n',MACH(1),' ! Mach Points (nd)');
for ii = 2:length(MACH)
  fprintf(fid,'%15.10e %s \n',MACH(ii),'!');
end

fprintf(fid,'%15.10e %s \n',SLCOP(1),' ! SLCOP (m)');
for ii = 2:length(MACH)
  fprintf(fid,'%15.10e %s \n',SLCOP(ii),' ! ');
end

fprintf(fid,'%15.10e %s \n',BLCOP(1),' ! BLCOP (m)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',BLCOP(ii),' ! ');end


fprintf(fid,'%15.10e %s \n',WLCOP(1),' ! WLCOP (m)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',WLCOP(ii),' ! WLCOP (m)');end


fprintf(fid,'%15.10e %s \n',SLMAG(1),' ! SLMAG (m)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',SLMAG(ii),' ! SLMAG (m)');end

fprintf(fid,'%15.10e %s \n',BLMAG(1),' ! BLMAG (m)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',BLMAG(ii),' ! BLMAG (m)');end

fprintf(fid,'%15.10e %s \n',WLMAG(1),' ! WLMAG (m)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',WLMAG(ii),' ! WLMAG (m)');end

fprintf(fid,'%15.10e %s \n',SLMAGA2(1),' ! SLMAGA2 (m)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',SLMAGA2(ii),' ! SLMAGA2 (m)');end

fprintf(fid,'%15.10e %s \n',BLMAGA2(1),' ! BLMAGA2 (m)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',BLMAGA2(ii),' ! BLMAGA2 (m)');end

fprintf(fid,'%15.10e %s \n',WLMAGA2(1),' ! WLMAGA2 (m)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',WLMAGA2(ii),' ! WLMAGA2 (m)');end

fprintf(fid,'%15.10e %s \n',SLMAGA4(1),' ! SLMAGA4 (m)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',SLMAGA4(ii),' ! SLMAGA4 (m)');end

fprintf(fid,'%15.10e %s \n',BLMAGA4(1),' ! BLMAGA4 (m)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',BLMAGA4(ii),' ! BLMAGA4 (m)');end

fprintf(fid,'%15.10e %s \n',WLMAGA4(1),' ! WLMAGA4 (m)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',WLMAGA4(ii),' ! WLMAGA4 (m)');end

fprintf(fid,'%15.10e %s \n',CX0(1),' ! CX0 (nd)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',CX0(ii),' ! CX0 (nd)');end


fprintf(fid,'%15.10e %s \n',0,' ! CX0BB (nd)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',0,' ! CX0BB (nd)');end

fprintf(fid,'%15.10e %s \n',CX2(1),' ! CX2 (nd)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',CX2(ii),' ! CX2 (nd)');end

fprintf(fid,'%15.10e %s \n',CNA(1),' ! CNA (nd)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',CNA(ii),' ! CNA (nd)');end


fprintf(fid,'%15.10e %s \n',CNA3(1),' ! CNA3 (nd)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',CNA3(ii),' ! CNA3 (nd)');end

fprintf(fid,'%15.10e %s \n',CNGAMA3(1),' ! CNGAMA3 (nd)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',CNGAMA3(ii),' ! CNGAMA3 (nd)');end

fprintf(fid,'%15.10e %s \n',CY0(1),' ! CY0 (nd)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',CY0(ii),' ! CY0 (nd)');end

fprintf(fid,'%15.10e %s \n',CZ0(1),' ! CZ0 (nd)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',CZ0(ii),' ! CZ0 (nd)');end

fprintf(fid,'%15.10e %s \n',CYPA(1),' ! CYPA (nd)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',CYPA(ii),' ! CYPA (nd)');end

fprintf(fid,'%15.10e %s \n',CLP(1),' ! CLP (nd)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',CLP(ii),' ! CLP (nd)');end

fprintf(fid,'%15.10e %s \n',CLDD(1),' ! CLDD (nd)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',CLDD(ii),' ! CLDD (nd)');end

fprintf(fid,'%15.10e %s \n',CNGAMA3(1),' ! CLGAMA3 (nd)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',CNGAMA3(ii),' ! CLGAMA3 (nd)');end

fprintf(fid,'%15.10e %s \n',CMQ(1),' ! CMQ (nd)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',CMQ(ii),' ! CMQ (nd)');end

fprintf(fid,'%15.10e %s \n',CMQA2(1),' ! CMQA2 (nd)');
for ii = 2:length(MACH)
fprintf(fid,'%15.10e %s \n',CMQA2(ii),' ! CMQA2 (nd)');end

if ICANARDS
  fprintf(fid,'%d %s \n',ICANARDS,' ! ICANARDS');
  fprintf(fid,'%d %s \n',NCANARDS,' ! Number of Canards');
  for ii = 1:NCANARDS
    fprintf(fid,'%15.10e %s %d %s \n',SCAN(ii),'! Canard ',ii,' area (m^2), SCAN()');
    fprintf(fid,'%15.10e %s %d %s \n',SLCAN(ii),'! Canard ',ii,' station line (m), SLCAN()');
    fprintf(fid,'%15.10e %s %d %s \n',BLCAN(ii),'! Canard ',ii,' butt line (m), BLCAN()');
    fprintf(fid,'%15.10e %s %d %s \n',WLCAN(ii),'! Canard ',ii,' water line (m), WLCAN()');
    fprintf(fid,'%15.10e %s %d %s \n',GAMCAN(ii),'! Canard ',ii,' sweep angle (rad), GAMCAN()');
    fprintf(fid,'%15.10e %s %d %s \n',PHICAN(ii),'! Canard ',ii,' orientation angle (rad), PHICAN()'); 
   fprintf(fid,'%15.10e %s %d %s \n',DELTACAN(ii),'! Canard ',ii,' command angle (rad), DELTACAN()');
  end
  fprintf(fid,'%d %s \n',NMACHCAN,'  ! Number of Canard Mach Number Points (nd), NMCAN');
  fprintf(fid,'%15.10e %s \n',MACHCAN(1),' ! Mach Points(nd),TOMCAN');
  for ii = 2:length(MACHCAN)
    fprintf(fid,'%15.10e %s \n',MACHCAN(ii),' ! ');
  end
  fprintf(fid,'%15.10e %s \n',TOCL1CAN(1),' ! CL1, TOCL1CAN');
  for ii = 2:length(MACHCAN)
    fprintf(fid,'%15.10e %s \n',TOCL1CAN(ii),' ! ');
  end
  fprintf(fid,'%15.10e %s \n',TOCL3CAN(1),' ! CL3, TOCL3CAN');
  for ii = 2:length(MACHCAN)
    fprintf(fid,'%15.10e %s \n',TOCL3CAN(ii),' ! ');
  end
  fprintf(fid,'%15.10e %s \n',TOCL5CAN(1),' ! CL5, TOCL5CAN');
  for ii = 2:length(MACHCAN)
    fprintf(fid,'%15.10e %s \n',TOCL5CAN(ii),' ! ');
  end
  fprintf(fid,'%15.10e %s \n',TOCD0CAN(1),' ! CD0, TOCD0CAN');
  for ii = 2:length(MACHCAN)
    fprintf(fid,'%15.10e %s \n',TOCD0CAN(ii),' ! ');
  end
  fprintf(fid,'%15.10e %s \n',TOCD2CAN(1),' ! CD2, TOCD2CAN');
  for ii = 2:length(MACHCAN)
    fprintf(fid,'%15.10e %s \n',TOCD2CAN(ii),' ! ');
  end
  fprintf(fid,'%15.10e %s \n',TOCICAN(1),' ! CDI, TOCDICAN');
  for ii = 2:length(MACHCAN)
    fprintf(fid,'%15.10e %s \n',TOCICAN(ii),' ! ');
  end
end
  
fclose(fid);

disp('File Created')
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
