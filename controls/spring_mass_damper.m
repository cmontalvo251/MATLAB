clear
clc
close all

%%%%Using the control system toolbox
%%%X = tf([first_vector],[second_vector])
%%%first_vector is the coeff of the num
%%%second_vector is the coeff of the dem
%%%X = zpk([zeros],[poles],[gain])
%%%%zeros are roots of num
%%%%poles are roots of den
%%%%gain is the constant applied to X
%%%%I like zpk better
X = zpk([],[0 -2 -4],[5])

impulse(X)

%%%Analytic Solution
tout = linspace(0,5,100);
c1 = 5/8;
c2 = 5/8;
c3 = -5/4;
xout = c1 + c2*exp(-4*tout) + c3*exp(-2*tout);

hold on

plot(tout,xout,'r-')




