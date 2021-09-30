function outs = mimo_functions(R,D)
%%%This function will compute the area 
%%and circumference of a circle and the
%%weight taking the radius and the density
%%as an input

outs(1) = pi*R^2;

outs(2) = 2*pi*R;

outs(3) = outs(1)*D;