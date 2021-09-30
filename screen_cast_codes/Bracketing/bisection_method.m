function bisection_method()

%%%%Defined Upper and Lower Bounds
xU = 3;
xL = 0;

%%%%Plot my function
x = linspace(xL,xU,100);
y = myfunc(x);
fig = figure();
set(fig,'color','white')
plot(x,y)
grid on
hold on
ymax = max(y);
ymin = min(y);
plot([xU xU],[ymin ymax],'k-')
plot([xL xL],[ymin ymax],'k-')

xn = xL;
delx = (xU-xL)/2;
yn = myfunc(xn);

while abs(yn) > 1e-8 %%%my threshold
    xn = xn + delx;
    plot([xn xn],[ymin ymax],'r-','LineWidth',2)
    pause
    ystar = myfunc(xn);
    %%%Decide what my new bounds are and if I should switch signs
    if sign(ystar) ~= sign(yn)
        delx = -delx;
    end
    yn = myfunc(xn);
    delx = delx/2;
end
xn
yn



function out = myfunc(in)


out = in.^2-1;