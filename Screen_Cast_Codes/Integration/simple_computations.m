function simple_computations()
close all
x = linspace(0,10,100);
dx = x(2)-x(1);

%%%%%%Reimman Sum Simple
fx = DrC(x);
I = sum(fx)*dx

plot(x,fx)
grid on
%%%%%%Trapezoidal Simple
fx1 = DrC(x+dx);
I = 0.5*sum(fx+fx1)*dx

%%%%%%Numerical Differentiation Simple
deriv = (DrC(x+dx)-DrC(x))/dx;

%%%Function Evaluation
function onree = DrC(eric)

onree = 4*eric;

