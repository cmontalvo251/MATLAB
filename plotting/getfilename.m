function filename = getfilename(i,L)
%%%filename = getfilename(i,L)
%%%%L = max number of digits
%%%i = current frame number
%%%use this in conjunction with save_frame(getfilename(framenumber,maxdigits))
numdx = [];
for ii = 1:L
  numdx = [numdx,'0'];
end
numi = num2str(i);
filename = [numdx(1:end-length(numi)),numi];
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
