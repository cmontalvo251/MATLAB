function M = save_animation()

figure();

x0 = -100;
y0 = 0;
for idx = 1:100
   cla;
   plot(x0,y0,'b.','MarkerSize',20) 
   x0 = x0+1;
   y0 = 0;
   axis([-100 100 -10 10])
   drawnow
   
   M(idx) = getframe;
end

%%%%Run this code in the command window using the following syntax

%%% >> M = save_animation()

%%% >> movie(M)