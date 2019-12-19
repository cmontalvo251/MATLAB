function out = delpsi(psi,psic)
%%%returns delta psi from a heading and a heading command without
%worrying about wrapping issues
%%%This computes delpsi = psi-psic btw

spsi = sin(psi);
cpsi = cos(psi);
spsic = sin(psic);
cpsic = cos(psic);

out = atan2(spsi*cpsic-cpsi*spsic,cpsi*cpsic+spsi*spsic);
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
