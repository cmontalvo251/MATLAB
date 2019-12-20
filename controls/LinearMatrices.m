function [Ac,Bc] = LinearMatrices(linearfunc,nonlinearfunc,xbar,t,ubar)

if nargin <= 4
  ubar = zeros(c,1);
end
[Ac,Bc] = feval(linearfunc,xbar,ubar);
[n,n] = size(Ac);
[n,c] = size(Bc);
xdotbar = feval(nonlinearfunc,t,xbar,ubar);
F = (xdotbar - Ac*xbar - Bc*ubar);
%%Augment the A and Bmatrix
Ac = [Ac F];
Ac = [Ac;zeros(1,n+1)];
Bc = [Bc;zeros(1,c)];

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
