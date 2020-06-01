A = [3 2; 4 1];
% equation for eigenvalus in terms of trace() and det()
% L^2 - L*trace(A) + det(A) = 0
% for reusability, coefficients of quadratic equation
a = 1;
b = -trace(A);
c = det(A);
L(1) = (-b+sqrt(b^2-4*a*c))/2*a; % 1st eigenvalue
L(2) = (-b-sqrt(b^2-4*a*c))/2*a; % 2nd eigenvalue
L = L.'; % eigenvalue matrix 
I = eye(size(A));
%First Eig
Atilde = A - L(1)*I;
A_ref = rref(Atilde)
v1 = [-A_ref(1,2);1];
v1 = v1/norm(v1)
%%%Second Eig
Atilde = A - L(2)*I;
A_ref = rref(Atilde)
v2 = [-A_ref(1,2);1];
v2 = v2/norm(v2)
%%%Or
v1_alt = [L(1)-A(1,1);A(1,2)]
v1_alt = v1_alt/norm(v1_alt)
v2_alt = [L(2)-A(1,1);A(1,2)]
v2_alt = v2_alt/norm(v2_alt)
%%Check for correct eigenvalues and vectors
A*v1-L(1)*v1 
A*v2-L(2)*v2
A*v1_alt-L(1)*v1_alt
A*v2_alt-L(2)*v2_alt
%%%For some reason the alt way above doesn't work. 
%%%Let's see why
%%Eig 1
%% 3 * x + 2 * y = 5 * x
%% 2 * y = 2 * x
%% Pick x = 1
%% y = 1
%% Let's create a formula
%% A(1,1) * x + A(1,2) * y = L(1) * x
%% A(1,2) * y = (L(1)-A(1,1)) * x
x = 1;
y = (L(1)-A(1,1))/A(1,2)*x;
v1_otherway = [x;y]
v1_otherway = v1_otherway/norm(v1_otherway)
%%Now let's do the same for Eig 2
%% 3 * x + 2 * y = -1 * x
%% 2 * y = -4 * x
%% pick x = 1
%% y = -2
%% Let's use the formula
x = 1;
y = (L(2)-A(1,1))/A(1,2)*x;
v2_otherway = [x;y]
v2_otherway = v2_otherway/norm(v2_otherway)
%%Alright let's check again
A*v1_otherway-L(1)*v1_otherway
A*v2_otherway-L(2)*v2_otherway

