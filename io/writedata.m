function writedata(filename,M)
%function writedata(filename,M)
%%This will write the cellarray contents in M to filename

l = length(M);

fid = fopen(filename,'w');

for ii = 1:l
  fprintf(fid,'%s \n',M{ii});
end

fclose(fid);

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
