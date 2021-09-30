clear
clc
close all

dx = 0.0001;
L = 10;

x = 0:dx:L;

q = x;

figure()
plot(x,q)

Ft = 0;

%%%Total Force
for idx = 1:length(q)-1
   Ft = Ft + q(idx)*dx; 
end

Ft

%%%%Center Point
%%%% int x * f(x) dx / Ft
xc = 0;
for idx = 1:length(q)-1
    xc = xc + x(idx)*q(idx)*dx;
end
xc = xc / Ft

ylim([0 max(q)])
xlim([0 L])
