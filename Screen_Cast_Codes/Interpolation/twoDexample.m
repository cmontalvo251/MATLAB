clear
clc
close all

X = [60 80 100 120]';
Y = [1 2 3 4]';

zz = [2 1.8 1.5 1;2.3 2.0 1.7 1.5;2.5 2.2 2.0 1.8;3 2.6 2.4 1.9];

fig = figure();
set(fig,'color','white')
set(gca,'FontSize',18)

for row = 1:length(X)
    for col = 1:length(Y)
        plot3(X(row),Y(col),zz(row,col),'b*','MarkerSize',30)
        hold on
    end
end

grid on

xstar = 99;
ystar = 2.05;

idx = 1;
while xstar > X(idx)
    idx = idx + 1;
end
x1 = X(idx-1);
x2 = X(idx);

jdx = 1;
while ystar > Y(jdx)
    jdx = jdx + 1;
end
y1 = Y(jdx-1);
y2 = Y(jdx);

z11 = zz(idx-1,jdx-1);
z12 = zz(idx-1,jdx);
z21 = zz(idx,jdx-1);
z22 = zz(idx,jdx);

plot3(x1,y1,z11,'ro','MarkerSize',30)
plot3(x2,y1,z21,'ro','MarkerSize',30)
plot3(x1,y2,z12,'ro','MarkerSize',30)
plot3(x2,y2,z22,'ro','MarkerSize',30)

zU = z12 + (z22-z12)/(x2-x1)*(xstar-x1);
zL = z11 + (z21-z11)/(x2-x1)*(xstar-x1);

plot3(xstar,y2,zU,'ms','MarkerSize',30)
plot3(xstar,y1,zL,'ms','MarkerSize',30)

zstar = zL + (zU-zL)/(y2-y1)*(ystar-y1);

plot3(xstar,ystar,zstar,'g^','MarkerSize',50)

