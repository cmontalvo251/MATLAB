clear
clc
close all

%%%%%OVERDAMPED
G = zpk([],[-2 -13],26)
step(G)
hold on
%%%%CRITICALLY DAMPED
G = zpk([],[-2 -2],4)
step(G,'g-')
%%%Underdamped
G = zpk([],[-2+3i,-2-3i],[13])
step(G,'r-')
%NO DAMPING
G = zpk([],[-3i 3i],[9])
step(G,'y-')
