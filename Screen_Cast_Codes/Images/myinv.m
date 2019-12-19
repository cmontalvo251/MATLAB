function invA = myinv(A)

AI = [A,eye(2)];

%%Normalize the pivot pt
AI(1,:) = AI(1,:)/AI(1,1);

%%%Zero out the 2nd row
AI(2,:) = AI(2,:) - AI(1,:)*AI(2,1);


%%%Normalize the pivot pt
AI(2,:) = AI(2,:)/AI(2,2);

%%%Zero out the 1st row
AI(1,:) = AI(1,:) - AI(2,:)*AI(1,2)

invA = AI(:,3:4);