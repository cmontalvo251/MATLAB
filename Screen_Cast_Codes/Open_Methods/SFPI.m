function SFPI()

close all

x = -2:0.1:2;

figure()
plot(x,f(x))


%%%Translate the function into the form x = g(x)
figure()
ylin = x;
plot(x,ylin,'b-','LineWidth',2)
hold on
plot(x,g(x),'r-','LineWidth',2)

%%%%Start out iteration loop
x1 = 0;
x2 = g(x1);
%%^^^ Initial conditions
iter = 0;
while abs(x2-x1) > 1e-2
   plot([x1 x1],[x1 g(x1)],'k-')
   plot([x1 x2],[x1 g(x2)],'k--')
   pause
   x1 = x2;
   x2 = g(x1);
   iter = iter + 1;
end
iter
x1
x2


function out = f(x)

out = x.^2 -2*x-3;

function out = g(x)

%%% 2x = x^2 - 3
%%% x = (x^2-3)/2

out = (x.^2-3)/2;