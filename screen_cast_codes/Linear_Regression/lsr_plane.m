%%%Least Squares Regression of a Plane
clear
clc
close all
xvector = linspace(-10,10,5);
yvector = linspace(-20,20,5);
[xmatrix,ymatrix] = meshgrid(xvector,yvector);
%%%z = 5*x + 6*y + NOISE
%%a0 = 5
%%a1 = 6
zmatrix = 5*xmatrix + 6*ymatrix + 2*(rand(5,5)-0.5)*30;
%mesh(xmatrix,ymatrix,zmatrix)
plot3(xmatrix,ymatrix,zmatrix,'b*')
hold on
grid on

%%%Assume that you have the coordinates x,y,z but not the a0,a1
% z1 = a0*x1 + a1*y1
% z2 = a0*x2 + a1*y2
% ....
% zn = a0*xn + a1*yn
% zn = [xn yn] * [a0;a1]
% Stack these together
% Z = [z1;z2;...zn]  -> N x 1
% H = [x1 y1 ; x2 y2 ; ... ; xn yn]; N x 2
% A = [a0;a1] -> 2x1
% Z = H*A -> Nx1 = Nx2 * 2x1
% Astar = (H'*H)^-1 * H'* Z
Z = [];
H = [];
for idx = 1:length(xvector)
  for jdx = 1:length(yvector)
    Z = [Z;zmatrix(jdx,idx)];
    H = [H;[xvector(idx) yvector(jdx)]];
  end
end
Astar = inv(H'*H)*H'*Z
zmatrix_fit = Astar(1)*xmatrix + Astar(2)*ymatrix;
mesh(xmatrix,ymatrix,zmatrix_fit)
