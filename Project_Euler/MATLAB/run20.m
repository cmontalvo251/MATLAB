%%Problem 20
%%Compute 100! and sum up the digits

clear
clc
close all

global slength

tic

slength = 200;

format long g

%%Initialize
%%%Add Zeros to equal 100 characters
num1 = '1';
zeros1 = num2str(zeros(1,slength-length(num1)));
zeros1 = zeros1(zeros1 ~= ' ');
finalnumber = [zeros1 '1'];
final = 1;

for ii = 99:-1:2
  num = num2str(ii);
%  disp(['Times ',num])
  zeros1 = num2str(zeros(1,slength-length(num)));
  zeros1 = zeros1(zeros1 ~= ' ');
  multiplicator = [zeros1 num];
  finalnumber = multiplication(finalnumber,multiplicator);
%  final = ii*final;
%  disp(final);
%  pause
end
finalnumber
%%Now sum up digits
answer = 0;
for ii = 1:length(finalnumber)
  answer = answer + str2num(finalnumber(ii));
end
answer

toc