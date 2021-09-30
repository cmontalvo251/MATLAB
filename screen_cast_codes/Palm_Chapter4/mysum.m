clear 
clc


f = [3 9 27 4 42 -90 32 56 78 12];

F = 0;
for index = 1:length(f)
    fi = f(index);
    F = F + fi;
end

F