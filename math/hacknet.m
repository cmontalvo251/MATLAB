function letter_perms = hacknet(letters)

L = length(letters);

permutations = myperm(1:L);

[r,c] = size(permutations);

letter_perms = {};

for idx = 1:r
  letter_perms = [letter_perms;letters(permutations(idx,:))];
end

%%%Since some letters might repeat get rid of the
%%%repeats
letter_perms = unique(letter_perms);

%%%%Write to file
writedata('hacknet.txt',letter_perms)