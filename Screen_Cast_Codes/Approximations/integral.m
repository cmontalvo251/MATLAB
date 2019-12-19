function out = integral(N)
%%%N is the number of intervals

x = linspace(0,5,N);
y = x.^2;
dx = (5-0)/N;

out = 0;

for idx = 1:length(x)
    out = out + y(idx)*dx;
end

%%Actual Answer 
%%% integral of x^2 = x^3/3

