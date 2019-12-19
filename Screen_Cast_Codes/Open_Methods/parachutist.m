clear
clc
close all

%K = 1:100;
m = 82;
g = 9.81;

K = 0:0.1:10;

V = ((m*g)./K).*(1-exp(-K*4/m))-36;

plot(K,V)
grid on
set(gca,'FontSize',18)

%%%Inital Guess
K = 4;
%%%
VK = ((m*g)./K).*(1-exp(-K*4/m))-36;

delK = 1;

Ki1 = K + delK;

VKi1 = ((m*g)./Ki1).*(1-exp(-Ki1*4/m))-36;

Vprime = (VKi1 - VK)/delK;

K1 = K - VK/Vprime



