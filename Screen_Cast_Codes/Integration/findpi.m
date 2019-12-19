x = 1;
piapprox = 0;
iterations = 1= 00;
for ii = 1:iterations
  N = 1 + 2*(ii-1);
  piapprox  = piapprox + (-1)^(ii+1)*(x^N)/N;
end
format long g
piapprox = piapprox*4
er = piapprox - pi
