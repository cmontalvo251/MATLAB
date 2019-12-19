function [divsum,numdiv] = divisors(n)

divsum = 1;
numdiv = 1;

num = 2;
sqrtn = sqrt(n);
while num <= sqrtn
  if ~mod(n,num)
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

