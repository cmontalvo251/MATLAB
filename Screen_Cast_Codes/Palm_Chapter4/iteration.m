clear
clc

tic

%%%Inefficient - Dynamically
%%%allocating my vector
 
x(1) = 1;

Niter = 10000;

for index = 1:Niter
    x(index+1) = -3*x(index);
end

toc

clear x

%%%Pre-allocating

tic

x = zeros(Niter+1,1);

for index = 1:Niter
    x(index+1) = -3*x(index);
end

toc
clear x

%%%%Iterative without saving
%%%%the vector
tic 
x1 = 1;
for index = 1:Niter
    xp1 = -3*x1;
    x1 = xp1;
end
toc

