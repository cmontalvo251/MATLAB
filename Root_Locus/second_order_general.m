%%%

clear
clc
close all

wn = 5;
h1 = figure();
ax1 = gca;
hold on
h2 = figure();
ax2 = gca;
pause
for zeta = 0:0.01:3
   G = tf([1],[1 2*zeta*wn wn^2]);
   step(ax2,G)
   s1 = -zeta*wn + wn*i*sqrt(1-zeta^2);
   s2 = -zeta*wn - wn*i*sqrt(1-zeta^2);
   plot(ax1,real(s1),imag(s1),'bx','MarkerSize',10)
   plot(ax1,real(s2),imag(s2),'bx','MarkerSize',10)
   pause(0.05)
end