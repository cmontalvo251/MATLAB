function out = fact(in)
%%%%This will compute the factorial

out = 1;
for idx = in:-1:2
    out = out*idx;
end
