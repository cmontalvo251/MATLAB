function xfinal = distance_traveled(V0,theta)
%%function output = name_of_function(inputs)

g = 9.81

V0x = V0*cos(theta)

V0y = V0*sin(theta)

tfinal = 2*V0y/g

xfinal = V0x*tfinal

