purge

x = 1:3;

y = 1:3;

[xx,yy] = meshgrid(x,y);

T00 = (75+0)/2;
T44 = (75+50)/2;
T04 = (100+75)/2;
T40 = (0+50)/2;

A = [ 4 -1 0 -1 0 0 0 0 0;
-1 4 -1 0 -1 0 0 0 0;
0 -1 4 0 0 -1 0 0 0;
-1 0 0 4 -1 0 -1 0 0;
0 -1 0 -1 4 -1 0 -1 0;
0 0 -1 0 -1 4 0 0 -1;
0 0 0 -1 0 0 4 -1 0;
0 0 0 0 -1 0 -1 4 -1;
0 0 0 0 0 -1 0 -1 4];
b = [75; 0; 50; 75; 0; 50; 175; 100; 150];
xans = A\b;
Tsolution = wrapmatrix(xans)';

%Tsolution = [43 33.3 33.89;63.21 56.11 52.34;78.59 76.06 69.71];

plottool(1,'Heat 2D',12,'x (m)','y (m)','Temperacture (Celsius)',['Heat' ...
		    ' 2D'])
        
%mesh(xx,yy,Tsolution)

T = [0 0 0 0 0;75 75 60 50 50;75 75 60 50 50;75 75 60 50 50;100 100 100 100 100];
for iter = 1:10
    for idx = 2:4
        for jdx = 2:4
            T(idx,jdx) = (T(idx+1,jdx) + T(idx-1,jdx) + T(idx,jdx+1) + T(idx,jdx-1))/4;
        end
    end
end
plottool(1,'Heat 2D',12,'x (m)','y (m)','Temperacture (Celsius)','Numerical Error')
		    
mesh(xx,yy,T(2:4,2:4)-Tsolution)


%%%Iterative Method
