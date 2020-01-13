clear
close all


Gol = zpk([],[0 -1 -2],[1]);

h1 = figure();
ax1 = gca;
hold on
h2 = figure();
ax2 = gca;
hold on
pause
for kp = 0.5:0.1:8
   denom = [1 3 2 kp];
   Gcl = tf([kp],denom) 
   poles = roots(denom)
   step(ax1,Gcl)
   plot(ax2,real(poles),imag(poles),'bx')
   drawnow
   %This works ish but don't do it
   %Gcl = simplify(Gol*kp/(Gol*kp+1))
end