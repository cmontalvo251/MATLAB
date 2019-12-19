function mypi = trapezoidal(N)


mypi = 0;
x = linspace(0,1,N);
dx = x(2)-x(1);

for idx = 1:length(x)-1
   mypi = mypi + 0.5*(f(x(idx))+f(x(idx+1)))*dx;
end
mypi = 4*mypi;

function y = f(x)

y = sqrt(1-x.^2);