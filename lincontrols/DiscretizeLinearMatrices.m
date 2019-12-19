function [Ad,Bd] = DiscretizeLinearMatrices(Ac,Bc,timestepDiscrete,NLinear)
if nargin < 4
  NLinear = 1;
end
[n,n] = size(Ac);
%%Discretize using the Matrix Exponential
Ad = expm(Ac*timestepDiscrete);
E = eig(Ad);
CheckInstable(E);
try Bd = inv(Ac)*(Ad-eye(n))*Bc;
catch me
  disp('Inverse undefined')
end
%Bd = Bc*timestepDiscrete;
%%Make Discrete Jump
Adnew = (Ad^NLinear);
%%Bd requires a for loop
Bdnew = 0.*Bd;
for ii = 0:NLinear-1
  Bdnew = Bdnew + (Ad^ii)*Bd;
end
Ad = Adnew;
Bd = Bdnew;

function w = CheckInstable(E)
ii = 1;
w = 0;
while ii <= length(E)
  if norm(E(ii)) > 1
    disp('Warning Discrete Matrix Unstable')
    w = 1;
    ii = 1e10;
  end
  ii = ii + 1;
end

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
