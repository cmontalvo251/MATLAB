X = (-10:2:10)';

Y = sign(x)';

close all
plot(X,Y,'b*')

%%%Polynomial Regression
order = 5;

H = ones(length(X),order+1);

for idx = 2:(order+1)
    H(:,idx) = X.^(idx-1);
end

Astar = inv(H'*H)*H'*Y;

%%%Smooth it out
Xsmooth = linspace(X(1),X(end),100);
H = ones(length(Xsmooth),order+1);

for idx = 2:(order+1)
    H(:,idx) = Xsmooth.^(idx-1);
end

Ytilde = H*Astar;

hold on

plot(Xsmooth,Ytilde,'r-')


%%%%Linear Splines

for idx = 1:length(X)-1
   m = (Y(idx+1)-Y(idx))/(X(idx+1)-X(idx));
   xspline = linspace(X(idx),X(idx+1),10);
   yspline = Y(idx) + m*(xspline-X(idx));
   plot(xspline,yspline,'g-')
end

