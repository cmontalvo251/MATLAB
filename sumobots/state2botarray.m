function botarray_out = state2botarray(x,botarray_in)

% Number of bots
n = numel(botarray_in);

botarray_out = botarray_in;

for i = 1:n
   botarray_out{i}.state(1) = x(1);
   botarray_out{i}.state(2) = x(2);
   x(1) = [];
   x(1) = [];
end
for i = 1:n
   botarray_out{i}.state(3) = x(1);
   botarray_out{i}.state(4) = x(2);
   x(1) = [];
   x(1) = [];
end


