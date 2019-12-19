%%Problem 7
%%find the 1001st prime
function run7()

tic

number = 5;
primenum = 13;
stop = 1;
while stop
  if numprime(primenum)
    number = number + 1;
  end
  if number == 10001
    stop = 0;
    primenum
  end
  primenum = primenum + 1;
end

toc



function answer = numprime(number)
%%Is this number a prime number
%ans = isprime(number);
counter = 2;
go = 1;
while (counter < (number/2)) && go
  if mod(number,counter)
    counter = counter + 1;
  else
    go = 0;
    answer = 0;
  end
end
if counter >= (number/2)
  answer = 1;
end