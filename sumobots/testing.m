%testing feval
clear
clc
clear test
F = @test;
a = path;
a(1:4);
addpath('bots\')
a = path;
a(1:4);
rehash
u = feval(F,10)

a = path;
a(1:4)