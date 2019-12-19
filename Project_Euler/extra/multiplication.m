function num = multiplication(str1,str2)
global slength

%%assume that str1 is a huge number and str2 is a 2 digit number
num = num2str(zeros(1,slength));
num = num(num ~= ' ');

dummy = 0;
done = 0;
ii = length(str1);

found = 0;
loc1 = 0;
while ~found
   loc1 = loc1 + 1;
   if loc1 == length(str1) || ~strcmp(str1(loc1),'0')
      found = 1;
   end
end
found = 0;
loc2 = 0;
while ~found
   loc2 = loc2 + 1;
   if loc2 == length(str2) || ~strcmp(str2(loc2),'0')
      found = 1;
   end
end
% if loc1 == 1 || loc2 == 1
%     disp('Overflow')
%     pause
% end

for ll = length(str2):-1:loc2
   dummy = 0;
   ii = length(str1);
   add1 = num2str(zeros(1,slength));
   add1 = add1(add1 ~= ' ');
   done = 0;
   while ~done
      mult1 = str2num(str1(ii));
      mult2 = str2num(str2(ll));
      result = mult1*mult2 + dummy;
      dummy = 0;
      while result >= 10
         result = result - 10;
         dummy = dummy + 1;
      end
      val = ii-length(str2)+ll;
      if val > 0
          add1(val) = num2str(result);
      end
      if ii == loc1
         if dummy
	   val = ii-1-length(str2)+ll;
	   if val > 0
	     add1(val) = num2str(dummy);
	   end
         end
         done = 1;
      end
      ii = ii - 1;
   end
   num = addition(num,add1);
end


% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
