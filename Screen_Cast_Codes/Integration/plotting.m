theta = pi/4;

V = 10;

vy = V*sin(theta); vx = V*cos(theta);

timestep = 0.1;

t = 0:timestep:3;

x0 = 0; y0 = 0;

x = x0 + vx*t;

g = 9.81;

y = y0 + vy*t - (1/2)*g*t.^2;



close all; fig = figure('Name','Trajectory'); 

set(fig,'color','white') 

set(axes,'FontSize',18) 

plot(x,y,'r--','LineWidth',2) 

grid on 

xlabel('X (m)')

ylabel('Y (m)')

title('Trajectory of a Ball')

tground = 2*vy/g;

tmax_height = tground/2;

xground = x0 + vx*tground;

ymax = y0 + vy*tmax_height - (1/2)*g*tmax_height^2;

axis([0 xground 0 ymax])

clear
clc
close all

theta = 0:0.01:(6*pi);

x = cos(theta);

y = sin(theta);

z = linspace(-1,1,length(theta));

fig = figure();

set(fig,'color','white')

set(axes,'FontSize',18)

plot3(x,y,z,'LineWidth',2)

grid on

xlabel('X (m)')
ylabel('Y (m)')
zlabel('Z (m)')

clear
clc
close all

fig = figure();

set(fig,'color','white')

set(axes,'FontSize',18)

x = linspace(-5,5,100);

y = linspace(-5,5,100);

[xx,yy] = meshgrid(x,y);

zz = xx.^2 + yy.^2;

mesh(xx,yy,zz);

grid on

xlabel('X (m)')
ylabel('Y (m)')
zlabel('Z (m)')

clear
clc
close all

fig = figure();

set(fig,'color','white')

set(axes,'FontSize',18)

x = [-1 1 1 -1 -1];

y = [-1 -1 1 1 -1];

z = [0 0 0 0 0];

radius = 1;

xx = [];yy = [];zz = [];

while radius >= 0

xx = [xx;radius*x];

yy = [yy;radius*y];

zz = [zz;z];

radius = radius - 0.1;

z = z + 1;

end

mesh(xx,yy,zz)

view(-27,30)

grid on

xlabel('X (m)')
ylabel('Y (m)')
zlabel('Z (m)')