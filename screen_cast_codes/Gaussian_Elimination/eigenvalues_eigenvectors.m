clear
clc
close all

A = [1 -2;-2 1]

det(A)

[V,L] = eig(A)

%%Inverse of V is V' because it is orthonormal

Areconstructed = V*L*V'

%%%Solve systems of equations - rref([A B])
%%% B = the right hand side of the equation

I = eye(2)

rref([A I]) %%%Row reduction

inv(A) %%%Built-in MATLAB functions

Ainv = V*(L^-1)*V'  %%Decomposing the matrix into eigenvectors and eigenvalues 



