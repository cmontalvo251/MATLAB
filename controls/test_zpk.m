clear
clc
close all

X = tf([1],[1 0])

%%%This is wrong on OCtave - should be 1
%%%This should be ok on MATLAB
impulse(X)

%%%This should produce x = t
%%%This works on MATLAB and Octave
figure()
step(X)