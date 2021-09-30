function M = save_animation2()
close all
x0 = -100;
y0 = 0;

for idx = 1:100
    
    cla;
    
    plot(x0,y0,'b.','MarkerSize',20)
    hold on
    
    x0 = x0 + 1;
    y0 = 0;
    
    axis([-100 100 -10 10])

    drawnow
    
    %%%%Add this to your code
    M(idx) = getframe;
    
end