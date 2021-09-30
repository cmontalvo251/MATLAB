function pong()
global move moveo

close all

%%%Make my game window
x_size = 100;
y_size = 30;
move = 0;
vx = 10;
vy = 5.8;
x = 0;
y = 0;
timestep = 0.05;

yp = 0;
yo = 0;
hp = 3*y_size/10;
hi = 3*y_size/10;

fig = figure('Name','Pong','keypressfcn',@keypress,'KeyReleaseFcn',@keyrelease);
set(fig,'color','white');

%%%Game engine that will never stop
while 1

    %%%Clear Figure
    cla;
    
    hold on
    
    %%%%Plot the ball
    plot(x,y,'b.','MarkerSize',40)
    
    %%%Move the ball
    x = x + vx*timestep;
    y = y + vy*timestep;
    
    %%%Make sure the ball doesn't go out of bounds
    if abs(y) > y_size
        vy = -vy;
    end
    %%%%Make sure the ball turns around if it hits the paddle but quits the
    %%%%game if it doesn't
    if abs(x) > x_size
        %%%the ball is out of bounds
        if x > x_size
            %%%Check if the ball hit my paddle
            if y < yp+hp && y > yp-hp
                %%%I am inbetween the paddle
                vx = -vx;           
            else
                disp('You lose')
                return;
            end
        else
            %%%Check if the ball hits my opponents paddle
            if y < yo+hi && y > yo-hi
                %%%I am inbetween the paddle
                vx = -vx;           
            else
                disp('You win')
                return;
            end
        end
        
    end

    %%%plot my paddle
    plot([x_size x_size],[yp-hp yp+hp],'k-','LineWidth',4)
    
    %%%plot opponents paddls
    plot([-x_size -x_size],[yo-hi yo+hi],'r-','LineWidth',4)
    
    %%%Get keyboard inputs
    if move
        yp = yp + move;
        move = 0;
    end
    
    if moveo
        yo = yo + moveo;
        moveo = 0;
    end
    
    %%%Set my game window
    axis([-x_size x_size -y_size y_size]) %%%Set the axis of my game
    
    %%%Clear the buffer and visualize the screen
    drawnow
    
end


function keypress(varargin) %%%varargin - variable number of arguments
global move moveo

key = get(gcbf,'CurrentKey');  %%%Get current state of keyboard

switch key
 case 'uparrow'
  move = 1;
 case 'downarrow'
  move = -1;
 case 'w'
  moveo = 1;
 case 's'
  moveo = -1;
end


function keyrelease(varargin)