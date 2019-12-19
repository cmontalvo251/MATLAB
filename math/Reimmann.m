function out = Reimmann(x,t)

out = 0;
for idx = 2:length(t)
  out = out + x(idx)*(t(idx)-t(idx-1));
end