%%Do own factorial
format long g
fact = 1;
for i = 100:-1:1
  fact = fact*i;
  disp(['Times',num2str(i)])
  num2str(fact)
  pause
end
clear
clc
fact = dlmread('factorial.out');
b = num2str(fact);
total = 0;
for i = 1:length(b)
  total = total+str2num(b(i));
end
total



