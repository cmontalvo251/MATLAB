function pong()
global move  moveo

close all


move = 0;
moveo = 0;

fig = figure('Name','Pong','keypressfcn',@keypress,'KeyReleaseFcn',@keyrelease);
set(fig,'color','black')

x_size = 100;
y_size = 30;
x = 0;
y = 0;
maxV = 10;
theta = 2*pi*rand;
vx = maxV*sin(theta);
vy = maxV*cos(theta);

hp = 3*y_size/10;
hi = 3*y_size/10;

yp = 0;
yi = 0;

timestep = 0.01;

%%%Game Engine
while 1
    %%%Clear my figure
    cla;
    hold on
        
    %%%Plot all of my objects
    plot(x,y,'g.','MarkerSize',40)
    
    plot([x_size x_size],[yp-hp/2 yp+hp/2],'g-','LineWidth',8)

    plot([-x_size -x_size],[yi-hi/2 yi+hi/2],'g-','LineWidth',8)
    
    axis([-x_size x_size -y_size y_size]) %%%These are the walls
    whitebg(fig,'k')
    
    %%%%Move the ball
    x = x + vx*timestep;
    y = y + vy*timestep;
    
    %%%Check for boundary
    if abs(x) > x_size
        if x > x_size
            %%%I'm on the right
            %%%Check if yp is inbetween yp+hp/2 and yp-hp/2
            if y > yp-hp/2 && y < yp+hp/2
                vx = -vx;
            else
                title('Left Player Wins')
                return;
            end
        else
            %%%I'm on the left
            %%%Check if yi is inbetween yi+hi/2 and yi-hi/2
            if y > yi-hi/2 && y < yi+hi/2
                vx = -vx;
            else
                title('Right Player Wins')
                return;
            end
        end
    end
    if abs(y) > y_size
        vy = -vy;
    end

    %%%%Check for Keyboard inputs
    %%%This is done automatically because it's in a separate thread
    
    %%%%Move the paddles
    if move
        yp = yp + move;
        move = 0;
    end
    if moveo
        yi = yi + moveo;
        moveo = 0;
    end
    
    %%%%Clear the graphics buffer
    drawnow
    
end


function keypress(varargin)
global move moveo

key = get(gcbf,'CurrentKey');

switch key
 case 'uparrow'
  move = 4;
 case 'downarrow'
  move = -4;
 case 'w'
  moveo = 4;
 case 's'
  moveo = -4;
end

function keyrelease(varargin)