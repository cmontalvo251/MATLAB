%%Find the iith term that has 1000 digits in the fibonacii sequence
purge

tic

maxdigits = 1000;
%zeros1 = num2str(zeros(1,maxdigits-3));
%zeros1 = zeros1(zeros1 ~= ' ');
%previousterm = [zeros1 '089'];
%nextterm = [zeros1 '144'];
previousterm = ['089'];
nextterm = ['144'];

term = 12;
found = 1;
numdigits2 = 0;
numdigits1 = 0;
while numdigits2 < maxdigits
   digits = length(nextterm);
   placeholder = nextterm;
   nextterm = addition(nextterm,previousterm,digits);
   previousterm = placeholder;
   term = term + 1;
   numdigits2 = 0;
   if ~strcmp(nextterm(1),'0')
      numdigits2 = digits;
   end
   if numdigits2 > numdigits1
      disp(numdigits2)
      numdigits1 = numdigits2;
   end
   if numdigits2 == digits
      nextterm = ['0' nextterm];
      previousterm = ['0' previousterm];
   end
end

toc

term

%%or just do this
gamma1 = 0.5*(1+sqrt(5))
gamma2 = 0.5*(1-sqrt(5))

C2 = (1-gamma1)/(gamma2^2-gamma1*gamma2)

C1 = (1-C2*gamma2)/gamma1

n = ceil((999 - log10(C1))/(log10(gamma1)))

