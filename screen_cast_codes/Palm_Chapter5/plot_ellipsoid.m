function plot_ellipsoid()
%%%No inputs or outputs
close all
clc

%%%Plot a circle

a = 1;
b = 1;
%theta = 0:(0.1):(2*pi+0.1);
theta = linspace(0,2*pi,100);

x = a*sin(theta);
y = b*cos(theta);

plot(x,y)

axis equal

%%%Plot a circle in 3 Dimensions
figure()

z1 = 5*ones(1,length(x));

plot3(x,y,z1)

grid on

%%%%Plot two more circles
hold on

z2 = zeros(1,length(x));

plot3(x,y,z2)

z3 = -5*ones(1,length(x));

plot3(x,y,z3)


%%%Plot a cylinder

%%%Convert my vectors to matrices
figure()

xx = [0.1*x;x;0.1*x]; %%%Top;middle;bottom
yy = [0.1*y;y;0.1*y]; %%%Top;middle;bottom
zz = [z1;z2;z3]; %%%Top;middle;bottom
size(xx)
size(yy)
size(zz)

mesh(xx,yy,zz)


%%%%Plot a cylinder with a lot of circles

num_circles = 100;
figure()
hold on


t = 21.5;
ma = 128;
mi = 30;
z = linspace(-t,t,num_circles);
%%%Empty Vectors
xx = [];
yy = [];
zz = [];
for zdx = 1:num_circles
    
    zii = z(zdx)*ones(1,length(x));
        
    %%%Plot a circle num_circle times
    
    radius = 1*sqrt(1-(zii(1)/t)^2); %%Maximum value of 1
    
    %plot3(radius*x,radius*y,zii)
    %view([-27 30])
    %pause(0.1)
    %drawnow
    
    %%%Concatenate my vectors
    xx = [xx;ma*radius*x];
    yy = [yy;mi*radius*y];
    zz = [zz;zii];
    
end

axis equal

mesh(xx,yy,zz)



end