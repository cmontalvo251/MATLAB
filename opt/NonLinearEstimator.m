function [delJ,del2J,J0] = NonLinearEstimator(costfunction,theta0,del,z,extinputs)
%%This function assumes that you have some function f=f(theta)
%%You then have some metric J to base on the error E
%%This function will return the gradient of J and the second
%gradient del2J
%NonLinearEstimator(costfunction,theta0,del,z,extinputs)
%costfunction is @function with input theta and J
%del is finite differencing value
%z is your measured result

%%Initialize variables
numparams = length(theta0);
delJ = zeros(numparams,1);
del2J = zeros(numparams,numparams);
JJmat = del2J;
JJvec = delJ;

%%Make initial call to costfunction
J0 = feval(costfunction,theta0,z,extinputs);
if J0 > 1e-8
%%Compute delJ using central differencing
for ii = 1:numparams
  theta0(ii) = theta0(ii) + del;
  Jup = feval(costfunction,theta0,z,extinputs);
  theta0(ii) = theta0(ii) - del; 
  delJ(ii) = (Jup-J0)./(del);
  JJvec(ii) = Jup;
end
%Compute 2nd gradient
for ii = 1:numparams
  for jj = ii:numparams
    theta0(ii) = theta0(ii) + del;
    theta0(jj) = theta0(jj) + del;
    Jcur = feval(costfunction,theta0,z,extinputs);
    JJmat(ii,jj) = Jcur;
    JJmat(jj,ii) = Jcur;
    del2J(ii,jj) = (JJmat(ii,jj)-JJvec(jj)-JJvec(ii)+J0)/(del^2);
    del2J(jj,ii) = (JJmat(jj,ii)-JJvec(ii)-JJvec(jj)+J0)/(del^2);
  end
end
end
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
