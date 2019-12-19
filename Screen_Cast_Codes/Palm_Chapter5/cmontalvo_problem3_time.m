function tgr = cmontalvo_problem3_time(h0,v0)
close all

%%%Define gravity
a = -9.81;

%%%%Find when ball hits ground
r = roots([(1/2)*a v0 h0]);

loc = find(r > 0);

tgr = r(loc);

%%%%Define a time and height vector
%%%%In my space I assume time is linear
%t = linspace(0,100,100);
timestep = 0.00001;


%h = h0 + v0*t + (1/2)*a*t.^2;



%for idx = 1:length(t)
hidx = h0;
tidx = 0;
idx = 1;

h = [];
t = [];
while hidx > 0
    hidx = h0 + v0*tidx + (1/2)*a*tidx.^2;
    h = [h;hidx];
    idx = idx + 1;
    tidx = tidx + timestep;
    t = [t;tidx];
end
tgr = t(idx);

%%%%I want to plot the trajectory of my sphere
fig = figure('Name','Trajectory');
set(fig,'color','white')
set(axes,'FontSize',18)
plot(t,h,'LineWidth',2)
xlabel('Time (sec)','FontSize',18)
ylabel('Height (m)','FontSize',18)
grid on

xlim([0 tgr])