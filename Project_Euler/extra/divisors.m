function [divsum,numdiv,divs] = divisors(n)
%%this function will return a the total number of divisors
%%and the sum of divisors excluding itself

divsum = 1;
numdiv = 1;

num = 2;
sqrtn = sqrt(n);
divs = [];
while num <= sqrtn
  if ~mod(n,num)
    divs = [divs,num];
    nnum = n/num;
    divsum = divsum + num + nnum;
    numdiv = numdiv + 2;
    if num == sqrtn
      numdiv = numdiv - 1;
      divsum = divsum - nnum;
    end
  end
  num = num + 1;
end


% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
