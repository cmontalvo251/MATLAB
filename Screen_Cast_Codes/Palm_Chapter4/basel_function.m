clear

F = 0;
for n = 1:100
   F = F + 1/n^2; 
end

abs_error = F-pi^2/6