%%%%%Sliding Mode Example
function sliding_mode()
global u OPENLOOP xc xdotc lambda xdbldotc k a

close all

%%%Build our sliding surface
% s = xtildedot + lambda*xtilde
% s = xdot - xdotc + lambda*(x-xc)
xdotc = 0;
xc = 0;
xdbldotc = 0;
a = 1.99999;
x = -5:1:5;
xdot = -5:1:5;
[xx,xxdot] = meshgrid(x,xdot);
lambda = 1; %%%Travel Time along surface
eta = 1;
F = 0.5;
k = eta+F;  %%%Travel time to surface
ss = xxdot - xdotc + lambda*(xx-xc);
mesh(xx,xxdot,abs(ss))
xlabel('x')
ylabel('xdot')
zlabel('s')
%Plot s = 0 = xdot - xdotc + lambda*(x-xc)
%xdot = xdotc - lambda*(x-xc)
xdotS = xdotc - lambda*(x-xc);
hold on
plot(x,xdotS,'r-') %%This is s = 0
plot(xc,xdotc,'ms','MarkerSize',20)
ax_mesh = gca;

%%%Simulate Open Loop Dynamics
OPENLOOP = 0; 
%tout = linspace(0,10,100);
figure()
hold on
ax_phase = gca;
figure()
hold on
ax_time = gca;
for idx = 1:length(x)
  for jdx = 1:length(xdot)
      [tout,xout] = odeK4(@Derivs,[0 10],[x(idx);xdot(jdx)],0.1);
      xi = xout(1,:);
      xdotj = xout(2,:);
      s = xdotj - xdotc + lambda*(xi-xc);
      plot3(ax_mesh,xi,xdotj,abs(s),'b-')
      
      plot(ax_phase,xi,xdotj,'b-')
      
      plot(ax_time,tout,xi,'b-')
      plot(ax_time,tout,xdotj,'r-')
      
      drawnow
   end
end 
plot(ax_phase,x,xdotS,'r-')

function dxdt = Derivs(t,xvec)
global u OPENLOOP xc xdotc lambda xdbldotc k a

x = xvec(1);
xdot = xvec(2);

%%%Dynamics
f = a*(-xdot^2)*cos(3*x);

%%%Control Law
if OPENLOOP
  u = 0;
else 
  xtildedot = xdot - xdotc;
  s = xdot - xdotc + lambda*(x-xc);
  fhat = -1.5*(xdot^2)*cos(3*x);
  u = -fhat + xdbldotc - lambda*xtildedot - k*sign(s);
end

xdbldot = f + u;

dxdt = [xdot;xdbldot];