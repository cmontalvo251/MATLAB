%%%%%Sliding Mode Example
function sliding_mode()
global OPENLOOP xc xdotc lambda xdbldotc

close all

%%%Build our sliding surface
% s = xtildedot + lambda*xtilde
% s = xdot - xdotc + lambda*(x-xc)
xdotc = 0;
xc = 0;
xdbldotc = 0;
x = -5:1:5;
xdot = -5:1:5;
figure()
lambda = 0.5; %%%Travel Time along surface
ax_mesh = gca;
if length(x) > 1 && length(xdot) > 1
    [xx,xxdot] = meshgrid(x,xdot);
    ss = xxdot - xdotc + lambda*(xx-xc);
    mesh(xx,xxdot,abs(ss))
end
xlabel('x')
ylabel('xdot')
zlabel('s')
%Plot s = 0 = xdot - xdotc + lambda*(x-xc)
%xdot = xdotc - lambda*(x-xc)
xdotS = xdotc - lambda*(x-xc);
hold on
plot(x,xdotS,'r-') %%This is s = 0
plot(xc,xdotc,'ms','MarkerSize',20)

%%%Simulate Open Loop Dynamics
OPENLOOP = 0; 
%tout = linspace(0,10,100);
figure()
hold on
ax_phase = gca;
figure()
hold on
ax_time = gca;
figure()
hold on
ax_control = gca;
plot(ax_phase,x,xdotS,'r-')
for idx = 1:length(x)
  for jdx = 1:length(xdot)
      [tout,xout,uout] = odeK4(@Derivs,[0 10],[x(idx);xdot(jdx)],0.01,42);
      xi = xout(1,:);
      xdotj = xout(2,:);
      s = xdotj - xdotc + lambda*(xi-xc);
      plot3(ax_mesh,xi,xdotj,abs(s),'b-')
      
      plot(ax_phase,xi,xdotj,'b-')
      
      plot(ax_time,tout,xi,'b-')
      plot(ax_time,tout,xdotj,'r-')
      
      plot(ax_control,tout,uout)
      
      drawnow
   end
end 


function [dxdt,u] = Derivs(t,xvec,y)
global OPENLOOP xc xdotc lambda xdbldotc

%%%Constants - this is the actual system
m = 1.2;
c = 3;
b = 1/m;

x = xvec(1);
xdot = xvec(2);

%%%Dynamics
f = -c*xdot*abs(xdot)/m;

%%%Control Law
if OPENLOOP
  u = 0;
else 
  %%%Define our estimates
  chatmhat = 8/14;
  xtildedot = xdot - xdotc;
  s = xdot - xdotc + lambda*(x-xc);
  fhat = -chatmhat*xdot*abs(xdot);
  eta = 3;
  F = (3/7)*xdot^2;
  uhat = -fhat + xdbldotc - lambda*xtildedot;
  bmin = 1/7;
  bmax = 1/3;
  bhat = sqrt(bmin*bmax);
  bata = (bmax * (1/bhat));
  k = bata*(F+eta) + (bata - 1)*abs(uhat);
  PHI = 0.1;
  u = (1/bhat)*(uhat - k * sat(s/PHI));
end

xdbldot = f + u*b;

dxdt = [xdot;xdbldot];