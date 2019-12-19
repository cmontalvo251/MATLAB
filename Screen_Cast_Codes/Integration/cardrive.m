clear
clc
close all

V = [0,30,35,0,0,50,50,0];
T = [0,10,15,16,17,20,25,30];

X = sum(V(2:end).*[T(2:end)-T(1:end-1)])/60

plottool(1,'Name',18,'Time (min)','Velocity (mph)');

plot(T,V,'bs')

for idx = 2:length(V)
    %if V(idx) > 0
    %    rectangle('Position',[T(idx-1) 0 T(idx)-T(idx-1) V(idx)],'FaceColor','r')
    %end
    xcoord = [T(idx-1) T(idx) T(idx) T(idx-1)];
    ycoord = [0 0 V(idx) V(idx-1)];
    patch(xcoord,ycoord,'g')
end

X = (1/2)*((0+30)*(10-0) + (30+35)*(15-10) + (30+35)*(15-10) + (35+0)*(16-15) + (0+50)*(20-17)+ (50+50)*(25-20) + (50+0)*(30-25))/60