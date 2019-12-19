
add = 1;
fibnum = 2;
sum = 2;
stop = 1;
while stop
  temp = fibnum;
  fibnum = fibnum + add;
  if fibnum > 4e6
    break
  end
  if ~mod(fibnum,2)
    sum = sum + fibnum;
  end
  add = temp;
end
sum
