function out = isMonotonic(invec)

inc = all(diff(invec)>0);

dec = all(diff(invec)<0);

if inc 
  out = inc;
elseif dec
  out = -dec;
else
  out = 0;
end
