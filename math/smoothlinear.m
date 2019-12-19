function out = smoothlinear(in,N)

out = in;

%%%Make endpoints identical
endpt = 0.5*(in(1) + in(end));
out(1) = endpt;
out(end) = endpt;

%%Smooth more points
if N > 0
  for ii = 2:N+1
    out(ii) = 0.5*(out(ii-1) + out(ii+1));
    out(end-ii+1) = 0.5*(out(end-ii)+out(end-ii+2));
  end
end

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
