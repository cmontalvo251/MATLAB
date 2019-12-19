purge

G = [5;5;5;0.02;0.02;0.02;10;5;5;1;0.2;0.2;5;5;5;0.1;5;5];

Gdiag = 1./(G.^2);

for ii = 1:length(G)
  disp(Gdiag(ii))
end

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
