function M = movie_test()

close all

timestep = 0.1;

x = 0;
y = 0;

vx = 1;
vy = 1;

fr = 1; %%%Create a frame counter

for t = 0:timestep:10
   
    cla;
    
    plot(x,y,'b.','MarkerSize',20)
    
    x = x + vx*timestep;
    
    y = y + vy*timestep;
    
    axis([0 10 0 10])
    
    drawnow
    
    M(fr) = getframe;
    fr = fr + 1; %%Incrementing the frame by 1
    
end