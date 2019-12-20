function [dxdt,u] = LinearDerivs(t,xlin)
global Ac Bc du0

%Compute Control
[n,m] = size(Bc);
u = zeros(m,1);

%%Phicommand
% phicommand = pi;
% u1 = cos(phicommand);
% u2 = sin(phicommand);
%u = [u1;u2];
dxdt = Ac*xlin + Bc*du0;
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
