function DispersionFile(DISOUT)

format long g

IANALTYPE = 1;
DISIMPACT = 0.000001;
NDIS = 100;
NPARAMS = 12;

Params = {'XBODYIC(1)','XBODYIC(2)','XBODYIC(3)','XBODYIC(4)','XBODYIC(5)','XBODYIC(6)','XBODYIC(7)','XBODYIC(8)','XBODYIC(9)','XBODYIC(10)','XBODYIC(11)','XBODYIC(12)'};

limits = [1,1,1,3,0.01,0.01,10,2,2,10,2,2];

fid = fopen(DISOUT,'wb');
fprintf(fid,'%s \n',[num2str(IANALTYPE),'     ! dispersion type (nd, 0=vertical plane, 1=horizontal plane)']);
fprintf(fid,'%s \n',[num2str(DISIMPACT),'     ! dispersion impact value (ft)']);
fprintf(fid,'%s \n',[num2str(NDIS),'    ! number of dispersion points (nd)']);
fprintf(fid,'%s \n',[num2str(NPARAMS),'       ! number of dispersion parameters (nd)']);
for ii = 1:NPARAMS
  fprintf(fid,'%s \n',[Params{ii},'    ! 1: dispersion variable, initial position(ft)']);
  for jj = 1:NDIS
    val = -limits(ii) + 2*limits(ii)*rand;
    fprintf(fid,'%s \n',num2str(val));
  end
end

fclose all;

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
