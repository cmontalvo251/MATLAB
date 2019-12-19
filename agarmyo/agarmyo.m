function agarmyo()
close all
global movex movey

fig = figure('Name','Agarmyo','keypressfcn',@keypress,'KeyReleaseFcn',@keyrelease);
set (gcf, 'WindowButtonMotionFcn', @mouseMove);
set(fig,'color','white')
set(axes,'FontSize',12)
grid on

myMass = 200;
mySize = sqrt(myMass);
mySpeed = 1;
colors = {'b','r','g','m','y','c','k'};
mycolor = colors{randint(1,1,length(colors))+1};

%%%Generate Random dots
screenSize = 200;
numberofDots = 100;
smallDots = zeros(4,screenSize);
for idx = 1:numberofDots
    smallDots(:,idx) = [randint(1,1,screenSize)*2-screenSize,randint(1,1,screenSize)*2-screenSize,randint(1,1,length(colors))+1,10]';
end

%%%Run Game Engine
while 1
    cla;
    grid on
    xlabel('X')
    ylabel('Y')
    
    %%%Draw Me
    circle(0,0,mySize,mycolor)
    
    %%Get Mouse coordinates
    %mouseMove()
    
    %Plot Small Dots and move them
    for idx = 1:numberofDots
        x = smallDots(1,idx);
        y = smallDots(2,idx);
        c = smallDots(3,idx);
        s = smallDots(4,idx);
        if s ~= 0
            circle(x,y,10,colors{c})
            smallDots(1,idx) = smallDots(1,idx) + mySpeed*movey;
            smallDots(2,idx) = smallDots(2,idx) - mySpeed*movex;
            dist = sqrt(x^2+y^2);
            if dist < mySize
                %%%EAT THEM!
                myMass = myMass + 10;
                mySize = sqrt(myMass);
                smallDots(1,idx) = randint(1,1,screenSize)*2-screenSize;
                smallDots(2,idx) = randint(1,1,screenSize)*2-screenSize;
            end
        end
    end
    %movey = 0;
    %movex = 0;
    axis equal
    xlim([-screenSize screenSize])
    ylim([-screenSize screenSize])
    drawnow
end


function keypress(varargin)
global movex movey

key = get(gcbf,'CurrentKey');

switch key
 case 'uparrow'
  movex = 1;
 case 'downarrow'
  movex = -1;
 case 'leftarrow'
  movey = 1;
 case 'rightarrow'
  movey = -1;
end

function mouseMove(object,eventdata)
global movex movey
C = get (gca, 'CurrentPoint');
%C = get(0,'PointerLocation')

mouseX = C(1,2);
mouseY = C(1,1);

delx = mouseX;
dely = mouseY;

if delx > 0
    movex = 1;
else
    movex = -1;
end

if dely > 0
    movey = -1;
else
    movey = 1;
end


function keyrelease(varargin)