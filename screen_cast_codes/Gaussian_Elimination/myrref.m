clear
clc
close all

format short

%A = [3 1 3;2 4 1;2 8 9];

B = [ 1 3 4; 3 -1 2; 4 2 2]

[v,s] = eig(B)

si = s(1,1)
vi = v(:,1)

A = B - si*eye(3)

%A = [0 0 1;1 2 3;0 1 -2];

%%%Will not work if
%%% 1 - det(A) = 0
%%%%2 - row swapping is required 

b = [3;4;5];

%%%% A * x = b

augA = [A eye(3)]

[s,c] = size(A);

for idx = 1:s
    %%%Check for row swapping
    if abs(augA(idx,idx)) < 1e-2
        disp('Need to row swap row = ')
        disp(num2str(idx))
        %%%Find a row to swap with
        for jdx = (idx+1):s
            if abs(augA(jdx,idx)) > 1e-2
                sw = jdx;
            end
        end
        if ~exist('sw','var')
            disp('Matrix probably singular')
        end
        disp('Swapping with row =')
        disp(num2str(sw))
        %%%Perform the swap
        temp_row = augA(sw,:); %%%saves the sw row
        augA(sw,:) = augA(idx,:);
        augA(idx,:) = temp_row
        clear sw
    end
    augA(idx,:) = augA(idx,:)/augA(idx,idx)
    for jdx = 1:s
        if idx ~= jdx
            augA(jdx,:) = augA(jdx,:) - augA(idx,:)*augA(jdx,idx)
        end
    end
end

disp('Using Built in Inverse')
disp(inv(A))
disp('Using Gaussian Elimination')
disp(augA(:,4:6))

%break
%rref(augA)

%%%%1st column
%augA(1,:) = augA(1,:)/augA(1,1)
%augA(2,:) = augA(2,:) - augA(1,:)*augA(2,1)
%augA(3,:) = augA(3,:) - augA(1,:)*augA(3,1)

%%%2nd column
%augA(2,:) = augA(2,:)/augA(2,2)
%augA(1,:) = augA(1,:)-augA(2,:)*augA(1,2)
%augA(3,:) = augA(3,:)-augA(2,:)*augA(3,2)

%%%3rd column
%augA(3,:) = augA(3,:)/augA(3,3)
%augA(1,:) = augA(1,:) - augA(3,:)*augA(1,3)
%augA(2,:) = augA(2,:) - augA(3,:)*augA(2,3)



