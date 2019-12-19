function num = addition(first,second)
%%Adds two numbers and returns the result

num = first;

dummy = 0;
done = 0;
ii = length(first);
while ~done
   add1 = str2num(first(ii));
   add2 = str2num(second(ii));
   result = add1 + add2 + dummy;
   if result >= 10
      result = result - 10;
      dummy = 1;
   else
      dummy = 0;
   end
   num(ii) = num2str(result);
   if ii == 1
      %%reached the end of both numbers
      if dummy
         %%still a number in the dummy space
	 if ii-1 > 0
	   num(ii-1) = '1';
	 end
      end
      done = 1;
   end
   ii = ii - 1;
end




% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
