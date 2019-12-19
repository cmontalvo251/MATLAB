clear
clc
close all

T = [0,linspace(1,10,5) + rand(5,1)']
r = 14/12; %ft
V = 2*pi*r./(T(2:end)-T(1:end-1))
x0 = 0; %ft
N = length(T)-1;
X = x0 + 2*pi*r*cumsum(T>0)