function x = botarray2state(botarray)

% Number of bots
n = numel(botarray);

% Populate x and v using botarray
for i = 1:n
    x(2*(i-1)+1) = botarray{i}.state(1);
    x(2*(i-1)+2) = botarray{i}.state(2);
    v(2*(i-1)+1) = botarray{i}.state(3);
    v(2*(i-1)+2) = botarray{i}.state(4);
end

x = [x v]';