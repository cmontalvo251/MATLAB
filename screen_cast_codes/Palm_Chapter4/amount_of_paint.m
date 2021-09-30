function amount_of_paint(P,A,price)
%%%p = sq ft of wall / gallon
%%%A = wall sq footage
%%%price = $ / gallon of paint


coverage = P;
total_sq_footage = A;

gallons = total_sq_footage/coverage;

total_price = price*gallons;

if total_price > 500
    disp('Immediately regret this decision')
else
    disp('Paint the world!')
end
