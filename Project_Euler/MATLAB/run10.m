%%Problem 10
%%Find the sum of all primes below 2million
clear
clc
tic
primenumbers = 1:2000000;
l = length(primenumbers);
primenumbers(1) = 0;
%%first get rid of all multiples of 2
primenumbers(4:2:end) = 0;
%%%Then get rid of all the multiples of everything else.
for i = 3:2:l-1
  if primenumbers(i) ~= 0
      primenumbers([i^2:primenumbers(i):end]) = 0;
  end
end
%primenumbers;
l= length(primenumbers);
% for i = 1:length(primenumbers)
%   disp([num2str(i),' out of ',num2str(l)])
  
%     if primenumbers(i) ~= 0
%       %answer = answer + primenumbers(i);
%       s = num2str(primenumbers(i));
%       if length(s) ~= length(answer)
% 	a = num2str(zeros(1,length(answer)-length(s)));
% 	a(a==' ') = [];
% 	s = [a s];
%       end
%       answer = addition(answer,s);
%       %disp(answer);
%       %pause
%     end
% end
answer = sum(primenumbers);
num2str(answer)
toc



