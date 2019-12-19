clear
clc
close all

%%% 1*x + 1*y = 2 -> y = 2-x
%%% -1x + 1*y = 4 -> y = 4+x

%%% 

%%% y = 2-x
%%% (2-x) - x = 4
%%% (2-2x) = 4
%%% 1 -x = 2
%%% x = -1
%%% y = 2-(-1) = 3

x = -4:0.1:4;

y1 = 2-x;
y2 = 4+x;

figure()
plot(x,y1,'r-')
hold on
plot(x,y2,'b-')

plot(-1,3,'ks','MarkerSize',4)

A = [1 1;-1 1]
B = [2;4];

det(A)

%%% A*v = B -> solve this I will get v = [x;y]

rref([A B]) %%<- augment matrix with B


%%% 2*x + 2*y = 1 -> y = (1-2*x)/2
%%% x + y = 1     -> y = 1-x

A = [2 2;1 1];
B = [1;1];

rref([A B]) %%%<- Naive Gaussian Elimination

det(A)

A(1,1)*A(2,2)-A(1,2)*A(2,1)

x = -4:0.1:4;
y1 = (1-2*x)/2;
y2 = 1-x;

figure()
plot(x,y1,'r-')
hold on
plot(x,y2,'b-')


