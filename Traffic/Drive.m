function Drive()
global CarLength SpeedLimit MaxAccelRate NumberofLanes NumberofCars TimeStep Cars cardx t 

for cardx = 1:NumberofCars
    state = [Cars(cardx).x,Cars(cardx).xdot];
    xdot1 = Gas(state);
    xdot2 = Gas(state + (xdot1*.5*TimeStep));
    xdot3 = Gas(state + (xdot2*.5*TimeStep));
    xdot4 = Gas(state + (xdot3*TimeStep));
    xdotRK4 = (1/6) * (xdot1 + (2*xdot2) + (2*xdot3) + xdot4);
    nextstate = state + (TimeStep * xdotRK4);
    Cars(cardx).x = nextstate(1);
    Cars(cardx).xdot = nextstate(2);
end

function statedot = Gas(state)
global Cars cardx NumberofLanes MaxAccelRate NumberofCars CarLength LaneWidth t

x = state(1);
xdot = state(2);
y = Cars(cardx).y;

%%%%Find the car in front of you, left and right
carfront = 0;
carLR = [0 0];
xLRdistance = [1e20 1e20];
xdistance = 1e20;
for ii = 1:NumberofCars
    if ii ~= cardx && Cars(ii).y == y && Cars(ii).x > x
        %%%This car is not you, it is in front of you and the car is in your lane
        if Cars(ii).x - x < xdistance
            carfront = ii;
            xdistance = Cars(ii).x - x;
            xfront = Cars(ii).x;
        end
    end
    if ii ~= cardx && Cars(ii).y ~= y
        if Cars(ii).y > y
            %%%This car is to your left
            LR = 1;
        else
            %%%This car is to your right
            LR = 2;
        end
        if abs(Cars(ii).x - x) < xLRdistance(LR)
            xLRdistance(LR) = abs(Cars(ii).x - x);
            carLR(LR) = ii;
        end
    end
end

%%%How Much are you willing to tailgate?
%%%Aggressive drivers will get really close
Tailgating = CarLength*(2-Cars(cardx).aggressive);

%%%Now decide if you can accelerate
if carfront && xdistance < 5*CarLength
    if xdistance > Tailgating
        %%%Accelerate to be right behind them
        xcommand = xfront - Tailgating;
        xdotcommand = Cars(carfront).xdot;
    else
        %%%Stay at the same speed
        xcommand = x;
        xdotcommand = Cars(carfront).xdot;
    end
else
    %%%No one is in front of you
    xcommand = x;
    xdotcommand = Cars(cardx).MaxSpeed;
end

%%%Crash Safety
%if xdistance < CarLength
%    xcommand = x;
%    xdotcommand = 0.9*xdot;
%end

%%%Throttle
Kp = -10;
Kd = -10;
ux = Kp*(x-xcommand) + Kd*(xdot-xdotcommand);

%%%Velocity Limit
if xdot > Cars(cardx).MaxSpeed && ux > 0
    ux = 0;
end
if xdot <= 0
    ux = 0;
end
%%%Acceleration Limit
if ux > 26.8/MaxAccelRate
    ux = 26.8/MaxAccelRate*sign(ux);
end

if Cars(cardx).MaxSpeed == 0 && ux > 0
    k = 1
end

%%%Logic to Change Lanes
%%%Should I change lanes?
turn = 0;
if xdot > 0 
if xdot < Cars(cardx).MaxSpeed || xdistance < 2*Tailgating 
    
   %%%Yea I want to change lanes
   %%%%Is there anyone in my way?
   if carfront && xdistance < 2*Tailgating
       %%%Yes someone is in my way
       %%%%Can I go left?
       TurnLeft = 0;
       if Cars(cardx).y < NumberofLanes && xLRdistance(1) > CarLength
           TurnLeft = 1;
       end
       %%%How bout right?
       TurnRight = 0;
       if Cars(cardx).y > 1 && xLRdistance(2) > CarLength
           TurnRight = 1;
       end
       turn = 0;
       if TurnRight && TurnLeft
           %%%Randomly pick one
           r = randi(2);
           if r == 2
               turn = -1;
           end
       end
       if TurnRight && ~TurnLeft 
           turn = -1;
       end
       if ~TurnRight && TurnLeft
           turn = 1;
       end
       Cars(cardx).y = Cars(cardx).y + turn;
   end
end
end

%%%EOMS
xdbldot = ux;

statedot(1) = xdot;
statedot(2) = xdbldot;

if xdistance < CarLength
%    title('Crash!!!')
%    pause
end
    
