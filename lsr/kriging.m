function c = kriging(pstar,LS,CORR,theta,k,pts)

n = length(LS);

%%Compute r
r = zeros(n,1);
for ll = 1:n
  r(ll) = Rmat(pstar,pts(:,ll),theta);
end

%%Compute f
for kk = 1:k
  f = fvec(pstar,k);
end

%Compute C vector
cT = f'*LS + r'*CORR;
c = cT';

function out = Rmat(w,x,theta)

p = 2;
d = length(x); %dimension of x (1-d,2-d?)
out = 1;
for ii = 1:d
  out = out*exp(-theta(ii)*(abs(w(ii)-x(ii)))^p);
end

function out = fvec(pt,k)

out = zeros(k,1);

x = pt(1);
y = pt(2);

for kk = 1:k
  switch kk
   case 1
    out(kk) = 1; %constant 
   case 2
    out(kk) = x + y; %linear
   case 3
    out(kk) = x^2 + y^2; %quadratic
   case 4
    out(kk) = x^3 + y^3; 
   otherwise
    out(kk) = 0;
  end
end
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
