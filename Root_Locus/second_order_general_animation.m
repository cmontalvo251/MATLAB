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
hold on
pause
zeta = 0.8;
for wn = 0.1:1:100
   %wn = sqrt(a^2+b^2);
   %zeta = a/wn;
   G = tf([wn^2],[1 2*zeta*wn wn^2]);
   step(ax2,G)
   s1 = -zeta*wn + i*wn*sqrt(1-zeta^2);
   s2 = -zeta*wn - i*wn*sqrt(1-zeta^2);
   plot(ax1,real(s1),imag(s1),'bx','MarkerSize',10)
   plot(ax1,real(s2),imag(s2),'bx','MarkerSize',10)
   pause(0.5)
end