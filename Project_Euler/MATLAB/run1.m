threes = 3:3:999;
fives = 5:5:999;
fifteens = 15:15:999;
locs = [];

for i = 1:length(fifteens)
  locs(i) = find(threes == fifteens(i));
end

threes(locs) = [0];

answer = sum(threes) + sum(fives)
