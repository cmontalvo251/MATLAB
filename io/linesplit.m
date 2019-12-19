function out = linesplit(this_line)

out = {};

L = length(this_line);

s = 1;
for idx = 1:L
  if this_line(idx) == ','
    out = [out;this_line(s:idx-1)];
    s = idx+1;
  end
end
