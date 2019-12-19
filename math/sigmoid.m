purge

x = -2:0.1:2;
z = -2:0.1:2;

[xx,zz] = meshgrid(x,z);
PSIY = xx;
lowerbound = 0.0001;
upperbound = 0.99;
breakpt = 1;
b = log(1/lowerbound-1);
a = (log(upperbound)-b)/breakpt;
for ii = 1:length(x)
  for jj = 1:length(z)
    delxz = sqrt(x(ii)^2 + z(jj)^2);
    PSIY(ii,jj) =  1-1./(1+exp(a*abs(delxz)+b));
  end
end
mesh(xx,zz,PSIY)
view([0 0])

%THOLD = 1-1./(1+exp(abs(20.*y)-8));
%plot(y,THOLD);

% dR = 20:-0.5:0;
% par = 5;
% psiy = 1./(1+exp(-par*(-dR+1)));
% psihold = 0;
% psimpc = 1-psihold-psiy;
% plot(dR,psimpc)
% hold on
% plot(dR,psihold,'r-')
% plot(dR,psiy,'g-')
% legend('MPC','HOLD','YERROR')

% phicommand = -1:0.1:1;
% ty = zeros(length(dR),length(phicommand));
% tmpc = ty;
% thold = tmpc;
% for ii = 1:length(dR)
%     for jj = 1:length(phicommand)
%         thold(ii,jj) = 1-1./(1+exp(20*abs(phicommand(jj))-8));
%         ty(ii,jj) = (1./(1+exp(-10*(-dR(ii)+4))))*(1-thold(ii,jj));
%         tmpc(ii,jj) = (1-ty(ii,jj))*(1-thold(ii,jj));
%     end
% end
% [phi,R] = meshgrid(phicommand,dR);
% plottool(1,'TY',12,'phi','Range','Val','YERROR',[-27 30])
% mesh(phi,R,ty)
% plottool(1,'TMPC',12,'phi','Range','Val','MPC',[-27 30])
% surf(phi,R,tmpc)
% plottool(1,'THOLD',12,'phi','Range','Val','HOLD',[-27 30])
% mesh(phi,R,thold)

% par = 3;
% ty = 1./(1+exp(-par*(-dR+5)));
% tmpc = 1-ty;
% thold = 1-tmpc-ty;
% figure()
% plot(dR,tmpc)
% hold on
% plot(dR,thold,'r-')
% plot(dR,ty,'g-')
% legend('MPC','HOLD','YERROR')
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
