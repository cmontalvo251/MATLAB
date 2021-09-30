%%%%Generate Seed Data
clear
clc
close all

X = (1:10)';
Y = -2.*X.^(2.3);
plot(X,Y,'b*')
%%%%The equation can be rearranged such that log_X(Y/a0) = a1
%%%Note that log_b(x) = log(x)/log(b)
%%%Thus log_X(Y/a0) = log(Y/a0)/log(X) = a1
%%%Then a1*log(X) = log(Y/a0)
%%% a1*log(X) = log(Y/a0)
%%%Again note that log(x/y) = log(x) - log(y)
%%% thus log(Y/a0) = log(Y) + log(a0)
%%% a1*log(X) = log(Y) + log(a0)
%%% Rearranging we have
%%% log(Y) = a1*log(X) + log(a0)
%%% so we have Z = log(Y)
%%% A = [log(a0) a1]'
%%% H = [1  log(X)]
%%% so Z = HA
%%% and inv(H'*H)*H'*Z = astar
Z = log(Y);
H = [ones(length(X),1),log(X)];
astar = inv(H'*H)*H'*Z;
loga0 = astar(1);
a0 = exp(loga0);
a1 = astar(2);
yest = a0.*X.^(a1);
hold on
plot(X,yest,'r--')
