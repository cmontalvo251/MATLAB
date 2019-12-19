%clear
clc
close all

%%%Simulate 1D Traffic
global CarLength SpeedLimit MaxAccelRate NumberofLanes NumberofCars TimeStep InitialCars Cars t

CarLength = 3; %%meters
CarWidth = 1; %%meters
SpeedLimit = 26.8; %%60 mph
MaxAccelRate = 8; %%sec from 0-60
NumberofLanes = 5;
NumberofCars = 10;
LaneWidth = 3; %%%meters
VisualizerON = 1; %boolean
SimTime = 500; %%Seconds
TimeStep = 0.1; %%Timestep

%%%Make the structure of Cars
Cars(1).x = 0;
%aggressive = [1.0 0.9 0.8 0.7 0.6];
for ii = 1:NumberofCars
    Cars(ii).x = 0 + 3*CarLength*(ii-1); %%meters
    Cars(ii).y = randi(NumberofLanes); %%integer 1-NumberofLanes
    Cars(ii).xdbldot = 0;  %%%Acceleration m/s^2
    Cars(ii).aggressive = rand; %%%Number between 0 and 1 -> 1 = Very Aggressive driver
    %Cars(ii).aggressive = aggressive(ii);
    Cars(ii).xdot = SpeedLimit+SpeedLimit/2*Cars(ii).aggressive; %%Speed m/s %%Initial Speed
    Cars(ii).MaxSpeed = Cars(ii).xdot; %%Maxspeed I'm willing to go
    %if ii > 1
    %    Cars(ii).xdot = 0;
    %    Cars(ii).MaxSpeed = 0;
    %end
    Cars(ii).clr = [Cars(ii).aggressive 0 1-Cars(ii).aggressive]; %%Color of Car More red means more aggressive
    Cars(ii).ChangingLanes = 0; %%Either takes -1 0 1 which siginifies which direction you are changing lanes
    Cars(ii).LaneCommand = Cars(ii).y; %%%Lane I'm moving too
end
%Cars(2).xdot = 0;
%Cars(2).MaxSpeed = 0;
%Cars(2).x = 200;
InitialCars = Cars;

carmain = 0;
agro = 0;
for ii = 1:NumberofCars
    if Cars(ii).aggressive > agro
        carmain = ii;
        agro = Cars(ii).aggressive;
    end
end

%%%Simulation Setup
iterations = round(SimTime/TimeStep);
xhistory = zeros(NumberofCars,iterations);
xdothistory = zeros(NumberofCars,iterations);
yhistory = zeros(NumberofCars,iterations+1);
for ii = 1:NumberofCars
    yhistory(ii,1) = Cars(ii).y;
end
thistory = zeros(1,iterations);

%%%Visualizer
if VisualizerON
    plottool(1,'Name',18,'X (m)','Y (m)');
    xwindow = 3*NumberofCars*CarLength;
    ycoordinate_lanes = linspace(-(NumberofLanes-1)*LaneWidth/2,(NumberofLanes-1)*LaneWidth/2,NumberofLanes);
end
t = 0;
for ii = 1:iterations
    if VisualizerON
        cla;
        %%%Title
        title(['t = ',num2str(t)])
        %%%Plot Cars
        xright = 0;
    end
    for ll = 1:NumberofCars
        if VisualizerON
            ycoord = ycoordinate_lanes(yhistory(ll,ii));
            CubeDraw(CarLength,CarWidth,1,Cars(ll).x,ycoord,CarLength,0,0,0,Cars(ll).clr);
        end
        %%%Save States
        xhistory(ll,ii) = Cars(ll).x;
        xdothistory(ll,ii) = Cars(ll).xdot;
        yhistory(ll,ii+1) = Cars(ll).y;
        thistory(ii) = t;
        if Cars(ll).x < Cars(carmain).x - xwindow/2;
            Cars(ll).x = Cars(carmain).x + xwindow;
        end
    end
    if VisualizerON
        xright = Cars(carmain).x+xwindow/2;
        xleft = xright - xwindow;
        %%%Set xwindow
        xlim([xleft xright])
        %%%Plot Lanes
        for jj = 1:NumberofLanes
            yup = ycoordinate_lanes(jj)+LaneWidth/2;
            ybottom = ycoordinate_lanes(jj)-LaneWidth/2;
            ymid = ycoordinate_lanes(jj);
            plot([xleft xright],[yup yup],'k-','LineWidth',4);
            plot([xleft xright],[ybottom ybottom],'k-','LineWidth',4);
            plot([xleft xright],[ymid ymid],'y--','LineWidth',4);
        end
        drawnow
%        axis square
    end
    %%%%Simulation
    Drive();
    t = t + TimeStep;
end
plottool(1,'X',18,'Time (sec)','X (m)');
plot(thistory,xhistory)

plottool(1,'xdot',18,'Time (sec)','Xdot (m/s)');
plot(thistory,xdothistory)

plottool(1,'Y',18,'Time (sec)','Y (m)');
plot(thistory,yhistory(:,1:end-1))