%%%Problem 3
function run3()
clear
clc

tic
x = 13195;
x = 600851475143;
num = 1;
maxprime = 1;
stop = 1;
while stop
  flag = numprime(num);
  if flag
    if ~mod(x,num)
      x = x/num;
      if num > maxprime
	maxprime = num;
      end
    end
  end
  num = num + 1;
  if num > x
    stop = 0; 
  end
end
maxprime
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





