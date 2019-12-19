function all_res = myperm (all_numbers)

L = length(all_numbers);
if L == 1
  all_res = all_numbers;
 else
  all_res = [];
  for idx = 1:L
    res = all_numbers(idx)*ones(factorial(L-1),1);
    numbers = all_numbers;
    numbers(idx) = []; 
    res = [res,myperm(numbers)];
    all_res = [all_res;res];
  end
end