clear
clc
close all

A = [ 1 2 3;4 5 6;7 4 9]

N = 3;
%%%What if you can't use eig?
[v,s] = eig(A)

%%%You need to find the eigenvalues
char_eqn = charpoly(A);
eigenvalues = roots(char_eqn);
s_without_eig = diag(eigenvalues)


%%%Find the eigenvectors

%%% A * v = s * v
%%% (A - s * I) * v = 0
%%% det(A - s*I) = 0
%%% inv(A - s*I) undefined
%%% ?????
v_without_eig = zeros(N,N);
for idx = 1:N
    si = eigenvalues(idx);
    Atilde = (A - si *eye(N));
    Atilde_red = rref(Atilde);
    %det(Atilde)

    %vi = zeros(N,1);

    %vi(N) = 1; %%%whatver I want

    %%%First row of Atilde_red
    
    %[ 1 0 -0.338 ] * [x y 1] = x - 0.338 = 0 - > x = 0.338
    %[ 0 1 -0.7763 ] * [x y 1] = y - 0.7763 = 0 - > y = 0.7763

    %vi = [0.338 ; 0.7763 ; 1]

    vi = [-Atilde_red(1:(N-1),N);1];

    %%%MATLAB likes to normalize eigenvectors
    vi = vi/norm(vi);
    
    v_without_eig(:,idx) = vi;
end

v_without_eig