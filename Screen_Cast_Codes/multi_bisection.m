function multi_bisection()

clc
close all


%%%Plot the entire function
xplot = 0:0.1:3;
yplot = 0:0.1:3;
[xx,yy] = meshgrid(xplot,yplot);
zz = f(xx,yy);

mesh(xx,yy,zz)
hold on
pU = [2,3];
zU = f(pU(1),pU(2));
pL = [0,0];
zL = f(pL(1),pL(1));

stepsize = norm(pU-pL);
direction_vector = (pU-pL)/norm(pU-pL);

while stepsize > 0.001
  %%%%Plot the current bisection
  plot3(pU(1),pU(2),zU,'b*','MarkerSize',10)
  plot3(pL(1),pL(2),zL,'r*','MarkerSize',10)
  plot3([pU(1) pL(1)],[pU(2) pL(2)],[zU zL],'g-','LineWidth',3)
  %%%Halve the stepsize.
  stepsize = stepsize/2;
  %%%Compute the bisection point
  pB = pL + direction_vector * stepsize;
  %%%Evaluate the function at the bisection point
  zB = f(pB(1),pB(2));
  plot3(pB(1),pB(2),zB,'k*','MarkerSize',10)
  %%%%Determine which point to reset
  if zB > 0
    pU = pB;
    zU = zB;
  else
    pL = pB;
    zL = zB;
  end 
end
pB
zB


function z = f(x,y)

z = x.^2-5 + y.^2-5;