clear
clc
close all

Vactual = 800; %%Velocity of my plane in ft/s

T = linspace(0,30,100)*60; %%%Time of flight in seconds

Xactual = Vactual*T;

plot(T,Xactual,'b-','LineWidth',2)

set(gca,'FontSize',18)
grid on

%%%GPS sensor on board the aircraft
%%%GPS operates a 4 Hz which 4 times per second deltaT = 1/4
%%%Every 0.25 seconds I get a data point

%%%Just for instructive purposes I assume I get a data point ever 
%%%50 seconds

deltat = 0.25;
TGPS = 0:deltat:(30*60);

xGPS = Vactual*TGPS + 20*rand(1,length(TGPS));

hold on
plot(TGPS,xGPS,'rs','MarkerSize',10)

%vGPS = (xGPS(2:end)-xGPS(1:end-1))/deltat; %%%Numerical Method - First
%Order Differentiation
vActual = 800+10*sin(0.01*TGPS(2:end));
vGPS = vActual + 100*(rand(1,length(TGPS(2:end)))-0.5);

figure()

plot(TGPS(2:end),vGPS)
set(gca,'FontSize',18)
hold on

%%%Filter
vFiltered = vGPS;
s = 0.03;
for idx = 2:length(vGPS)
    vFiltered(idx) = s*vGPS(idx) + (1-s)*vFiltered(idx-1);
end
plot(TGPS(2:end),vFiltered,'g-')
plot(TGPS(2:end),vActual,'r--')

legend('Sampled','Filtered','Actual')
