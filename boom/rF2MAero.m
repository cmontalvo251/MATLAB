function aero = rF2MAero(infile,outfile,SLCG)
format long g
%First we need to read in the 
fid = fopen(infile);
A = fgetl(fid);
aero.D = str2num(A(1:find(A=='!')-1));
A = fgetl(fid);
aero.NBODYFINS = str2num(A(1:find(A=='!')-1));
A = fgetl(fid);
aero.NMB = str2num(A(1:find(A=='!')-1));
NMB = aero.NMB;
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOMACH(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOMACH(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOSLCOP(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOSLCOP(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOBLCOP(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOBLCOP(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOWLCOP(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOWLCOP(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOSLMAG(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOSLMAG(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOBLMAG(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOBLMAG(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOWLMAG(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOWLMAG(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOSLMAGA2(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOSLMAGA2(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOBLMAGA2(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOBLMAGA2(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOWLMAGA2(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOWLMAGA2(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOSLMAGA4(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOSLMAGA4(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOBLMAGA4(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOBLMAGA4(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOWLMAGA4(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOWLMAGA4(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOCX0(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOCX0(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOCX0BB(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOCX0BB(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOCX2(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOCX2(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOCNA1(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOCNA1(i) = str2num(fgetl(fid));;
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOCNA3(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOCNA3(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOCNGAMA3(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOCNGAMA3(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOCY0(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOCY0(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOCZ0(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOCZ0(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOCYPA(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOCYPA(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOCLP(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOCLP(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOCLDD(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOCLDD(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOCLGAMA2(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOCLGAMA2(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOCMQ(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOCMQ(i) = str2num(fgetl(fid));
  end
end
for i=1:NMB
  if i == 1
    A = fgetl(fid);
    aero.TOCMQA2(i) = str2num(A(1:find(A=='!')-1));
  else
    aero.TOCMQA2(i) = str2num(fgetl(fid));
  end
end
fclose(fid);

IP = 1;

disp('Loaded Body File')

%%Now we need to start printing the output
fclose all;
fid = fopen(outfile,'wb');
fprintf(fid,'%s \n','1  ! Model Type (nd, 1=1D, 2=2D) ')
fprintf(fid,'%15.10e %s \n',aero.D,' ! Reference Diameter for Aerodynamic Loads (ft)'); 
fprintf(fid,'%15.10e %s \n',0,' !  Stationline of Aerodynamic Force (ft)'); 
fprintf(fid,'%15.10e %s \n',0,' ! Buttline of Aerodynamic Force (ft)'); 
fprintf(fid,'%15.10e %s \n',0,' ! Waterline of Aerodynamic Force (ft)'); 
fprintf(fid,'%15.10e %s \n',aero.NMB,' ! Number of Mach Number Points (nd)');
MACH = aero.TOMACH;
fprintf(fid,'%15.10e %s \n',MACH(1),' ! Mach Points (nd)');
for i=2:max(size(MACH))
 fprintf(fid,'%15.10e \n',MACH(i));
end
fprintf(fid,'%15.10e %s \n',aero.TOCX0(1),' ! CX0 (nd)');
for i=2:max(size(MACH))
 fprintf(fid,'%15.10e \n',aero.TOCX0(i));
end
fprintf(fid,'%15.10e %s \n',aero.TOCX2(1),' ! CX2 (nd)');
for i=2:max(size(MACH))
 fprintf(fid,'%15.10e \n',aero.TOCX2(i));
end
fprintf(fid,'%15.10e %s \n',aero.TOCY0(1),' ! CY0 (nd)');
for i=2:max(size(MACH))
 fprintf(fid,'%15.10e \n',aero.TOCY0(i));
end
fprintf(fid,'%15.10e %s \n',aero.TOCZ0(1),' ! CZ0 (nd)');
for i=2:max(size(MACH))
 fprintf(fid,'%15.10e \n',aero.TOCZ0(i));
end
fprintf(fid,'%15.10e %s \n',aero.TOCNA1(1),' ! CNA1 (nd)');
for i=2:max(size(MACH))
 fprintf(fid,'%15.10e \n',aero.TOCNA1(i));
end
fprintf(fid,'%15.10e %s \n',aero.TOCNA3(1),' ! CNA3 (nd)');
for i=2:max(size(MACH))
 fprintf(fid,'%15.10e \n',aero.TOCNA3(i));
end
fprintf(fid,'%15.10e %s \n',aero.TOCYPA(1),' ! CYPA1 (nd)');
for i=2:max(size(MACH))
 fprintf(fid,'%15.10e \n',aero.TOCYPA(i));
end
fprintf(fid,'%15.10e %s \n',aero.TOCYPA(1)*0,' ! CYPA3 (nd)');
for i=2:max(size(MACH))
 fprintf(fid,'%15.10e \n',aero.TOCYPA(i)*0);
end
fprintf(fid,'%15.10e %s \n',aero.TOCLDD(1),' ! CL0 (nd)');
for i=2:max(size(MACH))
 fprintf(fid,'%15.10e \n',aero.TOCLDD(i));
end
%%Compute CM0
fprintf(fid,'%15.10e %s \n',-aero.TOCZ0(1)*(aero.TOSLCOP(1)-SLCG),' ! CM0 (nd)');
for i=2:max(size(MACH))
 CM0 = -aero.TOCZ0(i)*(aero.TOSLCOP(i)-SLCG);
 fprintf(fid,'%15.10e \n',CM0);
end
%%Compute CN0
fprintf(fid,'%15.10e %s \n',aero.TOCY0(1)*(aero.TOSLCOP(1)-SLCG),' ! CN0 (nd)');
for i=2:max(size(MACH))
 CN0 = -aero.TOCY0(i)*(aero.TOSLCOP(i)-SLCG);
 fprintf(fid,'%15.10e \n',CN0);
end
fprintf(fid,'%15.10e %s \n',aero.TOCLP(1),' ! CLP (nd)');
for i=2:max(size(MACH))
 fprintf(fid,'%15.10e \n',aero.TOCLP(i));
end
%%Compute CMA1
CMA1 = (aero.TOSLCOP(1)-SLCG)*aero.TOCNA1(1)/aero.D;
fprintf(fid,'%15.10e %s \n',CMA1,' ! CMA1 (nd)');
for i=2:max(size(MACH))
  CMA1 = (aero.TOSLCOP(i)-SLCG)*aero.TOCNA1(i)/aero.D;
  fprintf(fid,'%15.10e \n',CMA1);
end
%%Compute CMA3
CMA3 = (aero.TOSLCOP(1)-SLCG)*aero.TOCNA3(1)/aero.D;
fprintf(fid,'%15.10e %s \n',CMA3,' ! CMA3 (nd)');
for i=2:max(size(MACH))
  CMA3 = (aero.TOSLCOP(i)-SLCG)*aero.TOCNA3(i)/aero.D;
  fprintf(fid,'%15.10e \n',CMA3);
end
fprintf(fid,'%15.10e %s \n',aero.TOCMQ(1),' ! CMQ1 (nd)');
for i=2:max(size(MACH))
 fprintf(fid,'%15.10e \n',aero.TOCMQ(i));
end
fprintf(fid,'%15.10e %s \n',aero.TOCMQA2(1),' ! CMQ3 (nd)');
for i=2:max(size(MACH))
 fprintf(fid,'%15.10e \n',aero.TOCMQA2(i));
end
%%Compute CNPA1
CNPA1 = (aero.TOSLMAG(1)-SLCG)*aero.TOCYPA(1)/aero.D;
fprintf(fid,'%15.10e %s \n',CNPA1,' ! CNPA1 (nd)');
for i=2:max(size(MACH))
  CNPA1 = (aero.TOSLMAG(i)-SLCG)*aero.TOCYPA(i)/aero.D;
  fprintf(fid,'%15.10e \n',CNPA1);
end
%%Compute CMA3
CNPA3 = (aero.TOSLMAG(1)-SLCG)*aero.TOCYPA(1)/aero.D;
fprintf(fid,'%15.10e %s \n',CNPA3,' ! CNPA3 (nd)');
for i=2:max(size(MACH))
  CNPA3 = (aero.TOSLMAG(i)-SLCG)*aero.TOCYPA(i)/aero.D;
  fprintf(fid,'%15.10e \n',CNPA3);
end


fclose all;
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
