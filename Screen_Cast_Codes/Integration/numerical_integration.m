function numerical_integration()
close all

%%%%Solve for pi
xplot = -1:0.001:1;
yplot = f(xplot);
figure()
plot(xplot,yplot)

%%%Use Reimman Sum
Ir = 0;
dx = 0.01;
for x = -1:dx:1
    Ir = Ir + f(x)*dx;
%    if f(x) > 0
%       rectangle('Position',[x 0 dx f(x)])
%   end
%   drawnow
%   pause
end
est_pi_R = Ir*4

%%%Use Trapezoidal Rule
It = 0;
for x = -1:dx:(1-dx)
    It = It + 0.5*(f(x)+f(x+dx))*dx;
    xtrapezoid = [x x+dx x+dx x];
    ytrapezoid = [0 0    f(x+dx) f(x)];
    patch(xtrapezoid,ytrapezoid,'r-')
    drawnow
    pause
end
est_pi_T = It*4



function y = f(x)

y = sqrt(1-x.^2);