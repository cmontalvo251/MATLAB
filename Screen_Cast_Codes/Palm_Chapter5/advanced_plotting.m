%%%%This is a script
close all
clear

% x = -10:0.01:10; 
% y = sin(x);
% 
% z = Function3D(x,y);

% fig = figure();
% set(fig,'color','white')
% plot3(x,y,z)
% xlabel('x')
% ylabel('y')
% zlabel('z')
% grid on
% hold on


x = linspace(-10,10,100); %%%makes matrix starting at -10 to 10 with 100 elements
y = linspace(-10,10,100);
zz = zeros(length(x),length(y)); %%%matrix of zeros with 100 rows and 100 columns

%%%Nested for loop
%%What is the length(x) - 100
for idx = 1:length(x) %%%starts the first for loop - index of the loop from 1 and ends at length(x)
    for jdx = 1:length(y) %%%Starts the second for loop - jdex of the loop from 1 to length(y) -> 100
         zz(idx,jdx) = Function3D(x(idx),y(jdx)); %%%x(idx) grabs the idx elements of x
         %%%y(jdx) - index of y
         %%%%Function3D(x(idx),y(jdx)) - Evaluates the function at
         %%%%x(idx),y(jdx)
         %%%%zz(idx,jdx) - idx is what? - index of the first for loop
         %%%%jdx is what? - index of the second loop
         %%%zz(1,2) zz(3,2) - zz(idx,jdx) - idxth row and the jdxth column
    end
end


%%%%Create my meshgrid
[xx,yy] = meshgrid(x,y);

fig = figure('Name','Mesh');
zzreal = real(zz);
mesh(xx,yy,zzreal)
xlabel('x')
ylabel('y')
zlabel('z')
set(fig,'color','white')
grid on
hold on


x1 = linspace(-10,10,100);
y1 = 4*ones(length(x1),1);
z1 = y1;
for idx = 1:length(x1)
    z1(idx) = Function3D(x1(idx),y1(idx));
end

plot3(x1,y1,z1)








