%%%Problem 5 - Project Euler
num = 20;
stop = 1;
inc = 20;
while stop
  found = 1;
  for i = 1:inc
    if mod(num,i)
      found = 0;
    end
  end
  if found
      stop = 0;
  else
    num = num + inc;
  end
end
num

