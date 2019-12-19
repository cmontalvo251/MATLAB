purge

nbeads = 6;

T = [200 0 0 0 0 200];

L = 10;

x = linspace(0,L,nbeads);

dx = x(2)-x(1);

alfa = 0.49;

dt = 0.1*0.5*dx/alfa;

qprime = 0.1;
rho = 1.225;
cp = 0.3;

F = qprime/(rho*cp);

tfinal = 10;

t = 0:dt:tfinal;

Tmat = zeros(length(t),nbeads);

Tmat(1,:) = T;

for l = 1:length(t)-1
   for idx = 2:nbeads-1
       Tmat(l+1,idx) = Tmat(l,idx) + alfa*dt/(dx^2)*(Tmat(l,idx+1)-2*Tmat(l,idx)+Tmat(l,idx-1)) + dt*F;
   end
   %%%Hold Boundary Conditions Constant
   Tmat(l+1,1) = T(1);
   Tmat(l+1,end) = T(end);
end

[xx,tt] = meshgrid(x,t);

plottool(1,'Mesh',12,'X (m)','Time (sec)','Temperature (Celsius)');
mesh(xx,tt,Tmat)

plottool(1,'Slices',12,'X (m)','Temperature (Celsius)');
colors = {'b-','r-','g-','m-','k-'};
skip = 10;
ctr = 1;
leg = {};
for idx = 1:skip:length(t)
    plot(x,Tmat(idx,:),colors{ctr},'LineWidth',2);
    ctr = ctr + 1;
    leg = [leg;['T = ',num2str(t(idx))]];
end
legend(leg)






