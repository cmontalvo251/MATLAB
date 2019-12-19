%%%Largest Number
bit63 = 0;
exponent = '11111111110';
fraction = ones(52,1);

%%%Smallest number
bit63 = 0;
exponent = '1';
fraction = zeros(52,1);

number = 1
for ii = 1:length(fraction)
    number = number + fraction(ii)*2^-ii
end

edec = bin2dec(exponent)

rmax = realmax;
number = (-1)^bit63*number*2^(edec-1023)


%%%Smallest denormalized 
bit63 = 0;
fraction = zeros(52,1);
fraction(end-1) = 1;

number = 0;
for ii = 1:length(fraction)
    number = number + fraction(ii)*2^-ii
end

number = (-1)^bit63*number*2^(-1023)
