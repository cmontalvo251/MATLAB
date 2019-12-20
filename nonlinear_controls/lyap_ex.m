function lyap_ex()
close all

x = linspace(1,10,100);
xdot = linspace(1,10,100);

[xx,xxdot] = meshgrid(x,xdot);

V = 0.5*(xx-5).^2 + 0.5*xxdot.^2;

figure()
mesh(xx,xxdot,V)

%uu = -100*xx;
uu = (5-xx-3*xxdot)./xx.^2;
xxdbldot = xx.^2*uu - xxdot.^5;
Vdot = (xx-5).*xxdot + xxdot.*xxdbldot;

figure()
mesh(xx,xxdot,Vdot)

figure()
%for xdot = -10:5:10
    [tout,xout] = ode45(@Derivs,[0 400],[1;-1]);
    hold on
    plot(tout,xout)
%end





function dxdt = Derivs(t,xvec)

x = xvec(1);
xdot = xvec(2);
u = (-100-x-3*xdot)/x^2;
if abs(u) > 100
    u = sign(u)*100;
end
u = -100*x;
xdbldot = ((x^2)*u) -(xdot^5);

dxdt = [xdot;xdbldot];