function out = factN(N)
%%%%Compute the Factorial of a number N


out = 1;

for idx = N:-1:1
    out = out*idx;
end