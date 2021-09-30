function [fact,time] = fortorial (n)

if n<0
  disp('Invalid')
  return
  elseif n==0
    disp(1)
    return
    end
    
a=1;
b=1;
%tic
for index = 1:n
  b=a*b;
  a=a+1;
end  
time = 0;
fact = b;

