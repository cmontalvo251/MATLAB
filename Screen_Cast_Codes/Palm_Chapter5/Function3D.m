function z = Function3D(x,y)

%z = sqrt(x.^3) + 0.0001*x.^2 + (1e-19)*exp(-5.*y) + 100*sin(24.*x) - log(atan(y));

z = sqrt(x.^2 + y.^2);