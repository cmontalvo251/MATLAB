function out = myfact(in)
%%%This function has 1 input it is a double and it is called in
%%This function has 1 output it is a double and it is called out


%5 * 4 * 3 * 2 * 1 or 
%in * in - 1 * in - 2 * in -3 .... 1

out = 1;
for idx = in:-1:1
   out = out*idx;
end