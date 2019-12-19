function [Wc] = controllability(A,B)
%%%THis will compute the controllability gramian for linear
%matrices a and B


[N,NA] = size(A);

[NB,P] = size(B);

Aii = A^0;
Wc = [0*Aii,zeros(N,N*(P-1))];

%%%%Sometimes there is an overflow issue due to multiplying A over and over
%%%%Again 
r = 0;

if NA == NB
  for ii = 1:N
    s = 1 + P*(ii-1);
    e = P*ii;
    Wc(:,s:e) = (Aii*B);
    if rank(Wc) >= r
        r = rank(Wc);
    else
        r = rank(Wc);
        Wc(:,s:e) = 0;
        disp('Limit of Precision Reached')
        break;
    end
    Aii = Aii*A;
  end
else
  disp('Matrix Dimensions Do Not Match - Controllability Error(~/Dropbox/Blackbox/controllability.m')
end

    

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
