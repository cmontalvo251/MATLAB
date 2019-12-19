purge

x = 0:0.1:10;

Ta = 16*x + 40;

plottool(1,'Heat',18,'X (cm)','T (degrees)');
plot(x,Ta,'LineWidth',2)

A = [1 -0.4 0 0 0;0 0.8 -0.4 0 0;0 -0.4 0.8 -0.4 0;0 0 -0.4 0.8 0;0 0 0 -0.4 -1];
b = [-16;16;0;80;-80];

v = A\b;

Tn = [40;v(2:4);200];

plot(0:2.5:10,Tn,'m*','LineWidth',2)

legend('Analytic Solution','Numerical Solution')

Ta = -5*x.^2 + 66*x + 40;

plottool(1,'Heat Q(x)',18,'X (cm)','T (degrees)');
plot(x,Ta,'LineWidth',2)

b = [-3.5;41;25;105;-67.5];

v = A\b;

Tn = [40;v(2:4);200];
plot(0:2.5:10,Tn,'m--*','LineWidth',2)
legend('Analytic Solution','Numerical Solution')