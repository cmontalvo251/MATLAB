%%Problem 14
%Which Starting number produces the longest chain
clear
close all
clc

tic

chain = 0;
answer = 0;
bigchain = 0;

for number = 1:1e6

   chain = 1;
   num = number;

   while num ~= 1
      %%even or odd
      if mod(num,2)
         num = 3*num + 1;
      else
         num = num/2;
      end
      chain = chain + 1;
   end
   chain;

   if chain > bigchain
      answer = number
      bigchain = chain
   end

   %pause

end

answer
bigchain

toc
