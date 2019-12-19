function out = hexhelp(in)

[r,c] = size(in);

out = '';

for idx = 1:r
  out = [out,in(idx,:)];
end

  