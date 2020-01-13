%%%Second Order Examples
clear
clc
close all

%%%First Order stable system
G = zpk([],[-3],[3])
step(G)

%%%UNstable first order system
figure()
G = zpk([],[3],[3])
step(G)

%%%Marginally stable system
figure()
G = zpk([],[0],[3])
step(G)

%%%Underdamped Second Order Stable System
figure()
G = zpk([],[-2-3i,-2+3i],[13])
step(G)

%%%Underdamped Second Order UnStable System
figure()
G = zpk([],[2-3i,2+3i],[-13])
step(G)

%%%Marginally Stable Oscillatory Second Order System
%%%Underdamped Second Order Stable System
figure()
G = zpk([],[-3i,3i],[13])
step(G)

%%%Marginally Stable Second Order System
%%%Underdamped Second Order Stable System
figure()
G = zpk([],[0,0],[13])
step(G)


