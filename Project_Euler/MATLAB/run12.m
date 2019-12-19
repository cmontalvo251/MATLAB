%%Problem 12
%%Find the triangle number with 500 divisors
clear
clc
tic
stop = 1;
n = 0;

%use fundamental theorem of arithmetic to obtain the number of divisors

n = 0;
nvec = [];
divvec = [];
trivec = [];
nmax = [];
divmax = [];
trimax = [];
num = 50;
divisors = 0;
notfound = 1;
divider = 2;
maxdivisors = 0;

while(maxdivisors < 500)
  n=n+1;
  num = n*(n+1)/2;
  divisors = 2;
  divider = 2;
  while(divider <= num/2)
    if (mod(num,divider) == 0)
      divisors=divisors+1;
    end
    divider=divider+1;
  end
  if (divisors > maxdivisors)
    disp('triangle number')
    num
    disp('number of divisors')
    divisors
    %pause
    trimax = [trimax num];
    divmax = [divmax divisors];
    nmax = [nmax n];
    maxdivisors = divisors;
  end
  divvec = [divvec divisors];
  nvec = [nvec n];
  trivec = [trivec num];
end
figure()
plot(nvec,trivec);
hold on 
plot(nmax,trimax,'r-');
xlabel('N')
ylabel('Triangle Number')
figure()
plot(nvec,divvec);
hold on
plot(nmax,divmax,'r-');
xlabel('N')
ylabel('Number of Divisors')
figure()
plot(trivec,divvec);
hold on
plot(trimax,divmax,'r-');
xlabel('Triangle Number')
ylabel('Number of Divisors')
















% while stop
%   clc
%   n = n + 1;
%   %%Generate Triangle Numbers
%   triangle = n*(n+1)/2;
%   if triangle > 4
%     primenumbers = 1:floor(triangle/2);
%     l = length(primenumbers);
%     primenumbers(1) = 0;
%     %%first get rid of all multiples of 2
%     primenumbers(4:2:end) = 0;
%     for i = 3:2:l-1
%       if primenumbers(i) ~= 0
%             primenumbers([i^2:primenumbers(i):end]) = 0;
%       end
%     end
%   else
%     primenumbers = 2:1:triangle;
%   end
%   primenumbers = primenumbers(primenumbers > 0);
%   %%Test which primes are divisible into the triangle number
%   for i = 1:length(primenumbers)
%     if mod(triangle,primenumbers(i))
%       primenumbers(i) = 0;
%     end
%   end
%   primefactors = primenumbers(primenumbers > 0);
%   %%Find prime factorization
%   num = triangle;
%   pfactors = [];
%   while num > 1
%     tries = primefactors(primefactors <= num);
%     for i = 1:length(tries)
%       if ~mod(num,tries(i))
% 	pfactors = [pfactors tries(i)];
% 	num = num/tries(i);
%       end
%     end
%   end
%   triangle
%   pfactors
%   itself = 1;
%   factors = pfactors;
%   if find(factors == triangle)
%       itself = 0;
%   end
%   numfactors = length(factors)+1+itself
%   if numfactors > 6
%     triangle
%     toc
%     return;
%   end
%   pause
% end
