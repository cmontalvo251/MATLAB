clear
clc
close all
clear

%%%Plot Main Function
X = (-10:2:10)';
Y = sign(X);
plot(X,Y,'b*')

%%%Regression Curve
O = 7;
H = ones(length(X),O+1);
for idx = 2:(O+1)
    H(:,idx) = X.^(idx-1);
end
Astar = inv(H'*H)*H'*Y;
Xsmooth = linspace(X(1),X(end),100);
Hs = ones(length(Xsmooth),O+1);
for idx = 2:(O+1)
    Hs(:,idx) = Xsmooth.^(idx-1);
end
Ytilde = Hs*Astar;
hold on
plot(Xsmooth,Ytilde,'r-')

%%%Linear Splines

%%% m = (y1-y0)/(x1-x0)
%%% y = m(x-x0) + y0
for idx = 1:length(X)-1
   m = (Y(idx+1)-Y(idx) )/(X(idx+1)-X(idx));
   xspline = X(idx):0.1:X(idx+1);
   yspline = m*(xspline-X(idx)) + Y(idx);
   plot(xspline,yspline,'g-')
end

%%%Quadratic Splines


