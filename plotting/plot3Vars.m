%%%Plotting with multiple variables
clear
clc
close all

%%%Create a 2D plot of y = sin(x)
x = -2*pi:1:2*pi;
y = sin(x);
plot(x,y)

%%%Create a path line in 3D 
figure()
z = sin(x);
plot3(x,y,z)

%%%What if I wanted a plane now in 3D
x3d = x;
y3d = x;
[xx,yy] = meshgrid(x3d,y3d);
zz = xx.^2 + yy.^2; %%% - > z = f(x,y)
figure()
mesh(xx,yy,zz)

%%%What I wanted a function of 3 variables
%%% w = f(x,y,z)
%%% w = x^2 + y^2 + z^2
x3var = x;
y3var = x;
z3var = x;
w3var = zeros(length(x3var),length(y3var),length(z3var));
for idx = 1:length(x3var)
    xi = x3var(idx);
    for jdx = 1:length(y3var)
        yj = y3var(jdx);
        for kdx = 1:length(z3var)
            zk = z3var(kdx);
            w3var(idx,jdx,kdx) = xi^2 + yj^2 + zk^2;
        end
    end
end
plottool(1,'Three Variables',12,'x','y','z')
plot3D(x3var,y3var,z3var,w3var,1,30)
