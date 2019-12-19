function [LS,CORR,pts] = krigingsetup(k,x,y,theta)
%%Kriging 2D method
%function [LS,CORR] = kriging(ys,k,x,y,theta)
%k = order of the model
%x = x-coordinates
%y = y-coordinates
%xstar and ystar are the point you are computing
%theta = [theta1,theta2] 

%%Total number of discrete data points
n = length(x)*length(y);

%%Generate vector of points
pts = zeros(2,n);
counter = 1;
for ii = 1:length(x)
  for jj = 1:length(y)
    pts(:,counter) = [x(ii);y(jj)];
    counter = counter + 1;
  end
end

%%Set up Kriging Parameters
R = zeros(n,n);
I = eye(n);

%%Contruct f
f = fvec([0;0],k);

%%Compute F
F = zeros(n,k);
for ii = 1:n
  F(ii,:) = fvec(pts(:,ii),k)';
end

%%%Compute R
for ii = 1:n
  for jj = 1:n
    R(ii,jj) = Rmat(pts(:,ii),pts(:,jj),theta);
  end
end

%%Compute Least Square Matrix and Correlation Matrix
invR = inv(R);
LS = inv(F'*invR*F)*F'*invR;
CORR = invR*(I-F*LS);

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
