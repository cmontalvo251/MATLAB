function lyap_ex()
close all
figure()
for x = -100:1:100
    [tout,xout] = ode45(@Derivs,[0 100],[x]);
    hold on
    plot(tout,xout)
    drawnow
end





function dxdt = Derivs(t,x)
dxdt =  -(x^4);

