%%%

clear
clc
close all

h1 = figure();
ax1 = gca;
hold on
h2 = figure();
ax2 = gca;
hold on
pause
for K = 0.1:0.1:100
   denom = [1 3 2 K];
   G = tf([K],denom)
   poles = roots(denom)
   pause
   for idx = 1:length(poles)
       plot(ax1,real(poles(idx)),imag(poles(idx)),'bx','MarkerSize',10)
   end
   step(ax2,G)
end