function fixed_point()

close all

x = -2:0.1:2;
ylin = x;
yg = g(x);

plot(x,ylin,'r-')
hold on
plot(x,yg,'b-')


x0 = 0;
xnew = g(x0);
xold = x0;
thresh = 1e-2;
iter = 0;
while abs(xnew - xold) > thresh
    plot([xold xold],[xold g(xold)],'k-')
    plot([xold xnew],[xold g(xnew)],'k--')
    pause
    xold = xnew;
    xnew = g(xold);
    iter = iter + 1;
end

iter
xold
xnew

function out = g(in)

out = (in.^2-3)/2;