clear
clc
close all

X = linspace(-pi,pi,10);
Y = X;

[xx,yy] = meshgrid(X,Y);

zz = 1 + 2*sin(2*xx) + 2*sin(2*yy);
[r,c] = size(zz);

fig = figure();
set(fig,'color','white')
set(gca,'FontSize',18)
xlabel('x')
ylabel('y')
zlabel('z')
hold on
grid on

for idx = 1:r
    for jdx = 1:c
        plot3(xx(idx,jdx),yy(idx,jdx),zz(idx,jdx),'b*','MarkerSize',10)
    end
end

xstar = -2;
ystar = 1.5;

locx = find(xstar < X,1);
locy = find(ystar < Y,1);

x0 = X(locx-1);
x1 = X(locx);
y0 = X(locy-1);
y1 = X(locy);

z00 = zz(locx-1,locy-1);
z10 = zz(locx,locy-1);
z01 = zz(locx-1,locy);
z11 = zz(locx,locy);

plot3(x0,y0,z00,'gs','MarkerSize',10)
plot3(x1,y0,z10,'gs','MarkerSize',10)
plot3(x0,y1,z01,'gs','MarkerSize',10)
plot3(x1,y1,z11,'gs','MarkerSize',10)

zU = z01 + (z11-z01)/(x1-x0)*(xstar-x0);
zL = z00 + (z10-z00)/(x1-x0)*(xstar-x0);

plot3(xstar,y0,zL,'r*','MarkerSize',10)
plot3(xstar,y1,zU,'r*','MarkerSize',10)

zstar = zL + (zU-zL)/(y1-y0)*(ystar-y0);

plot3(xstar,ystar,zstar,'k*','MarkerSize',10)










