%%Problem 16
%%Compute 2^1000 and sum up all the digits
clear
clc
close all

global slength

tic

format long g

num1 = 1;
num2 = 2;

%%Convert Numbers to strings
num1 = num2str(num1);
num2 = num2str(num2);
%%%Add Zeros to equal 100 characters
slength = 500;
dummy1 = num2str(zeros(1,slength));
dummy1 = dummy1(dummy1 ~= ' ');
dummy2 = num2str(zeros(1,slength));
dummy2 = dummy2(dummy2 ~= ' ');
dummy1(end-length(num1)+1:end) = num1;
dummy2(end-length(num2)+1:end) = num2;

%%Compute 2^1000
for i = 1:1000
   dummy1 = multiplication(dummy1,dummy2);
end
answer = dummy1;
%%Get rid of leading zeros
found = 0;
i = 1;
while ~found
   if i == length(answer) || ~strcmp(answer(i),'0')
      loc = i;
      found = 1;
   end
   i = i + 1;
end
answer = answer(loc:end)

%%Find sum of all digits
realanswer = 0;
for i = 1:length(answer)
   realanswer = realanswer + str2num(answer(i));
end

realanswer

toc



