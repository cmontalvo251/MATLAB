function out = slugft2kgm(in)

%%Convert ft to meters
%%3.28 ft = 1 m
out = in/(3.28^2);

%%Convert slug to lbf
out = out*32.2;

%%Convert lbf to N
out = out*4.44822;

%%Convert N to kg
out = out/9.81;
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
