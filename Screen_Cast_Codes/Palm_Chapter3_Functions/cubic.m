function [Mass,Weight,Vol] = cubic(side,density)
%%This function computes the volume of a cube
%%%[Mass,Weight,Vol] = cubic(side,density) 
%%%Side is in meters
%%%Density is in kg/m^3
%%%%MIMO function
%%%Multiple Inputs, Multiple Outputs

%Vol = side*side*side;
Vol = side^3; %%%m^3

Mass = density*Vol;   %%%kg

g = 9.81; %%m/s^2

Weight = Mass*g;