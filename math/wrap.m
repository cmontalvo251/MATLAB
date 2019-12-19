function out = wrap(in)
%%function out = wrap(in)
%%in is a Nx1 vector that converts a crazy 0 to infinity
%%limit file to a -pi to pi vector
out = in;
if max(max(in)) > 1e20
  disp('Maximum Input Variable size exceeded')
  return
end

for ii = 1:length(in)
  lcounter = 1;
  while out(ii) > pi
    out(ii:end) = out(ii:end)-2*pi;
    lcounter = lcounter + 1;
    if lcounter > 1000
      disp('Maximum Iteration in wrapping reached')
      break
    end
  end
  lcounter = 1;
  while out(ii) < -pi
    out(ii:end) = out(ii:end)+2*pi;
    lcounter = lcounter + 1;
    if lcounter > 1000
      disp('Maximum Iteration in wrapping reached')
      break
    end
  end
end

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
