function ztilde = myEuler(time,CDguess)

deltat = time(2)-time(1);

ztilde = zeros(length(time),1);
ztildedot = ztilde;

ztilde(1) = 100;
ztildedot(1) = 0;

g = 9.81;
rho = 1.225;
m = 10;
S = 1;

for n = 1:length(time)-1
   ztilde(n+1) = ztilde(n) + ztildedot(n)*deltat;
   ztildedbldot = -g + (1/(2*m))*rho*ztildedot(n)^2*S*CDguess;
   ztildedot(n+1) = ztildedot(n) + ztildedbldot*deltat;
end