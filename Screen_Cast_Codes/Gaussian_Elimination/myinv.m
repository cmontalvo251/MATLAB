function invA = myinv(A)

d = det(A);

[r,c] = size(A);

if abs(d) < 1e-5
    disp('This matrix is undefined')
    invA = zeros(r,c);
    return
end

AI = [A,eye(r,c)];

for col = 1:c
    %%%Normalize the colth row
    AI(col,:) = AI(col,:)/AI(col,col);
    %%%Loop through all rows and zero them out
    for row = 1:r
        if col ~= row
            AI(row,:) = AI(row,:)-AI(col,:)*AI(row,col);
        end
    end
end

invA = AI(:,c+1:(2*c));

