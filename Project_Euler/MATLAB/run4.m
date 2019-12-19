function run4()
clear
clc
%%Problem 4 
%Find the two largest 3 digit numbers whose product is a
%palindrome.
tic

num1 = [101:999];
num2 = [101:999];
stop = 1;
largest = 101;
ans1 = num1;
ans2 = num2;
for i = 1:length(num1)
  for j = 1:length(num2)
    product = num1(i)*num2(j);
    if product > largest
      if ispalindrome(product)
	largest = product;
	ans1 = num1(i);
	ans2 = num2(j);
      end
    end
  end
end
largest

toc

function out = ispalindrome(number)
number = num2str(number);
l = length(number);

if mod(l,2)
  %%odd number
  mark = (l-1)/2;
else
  %%even number
  mark = (l/2);
end
if strcmp(number(1:mark),number(end:-1:end-mark+1))
  out = 1;
else
  out = 0;
end