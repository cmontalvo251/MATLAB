function out = basel_function(N)

out = 0;

for idx = 1:N
    out = out + (1/(idx^2));
end
