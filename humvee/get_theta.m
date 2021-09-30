function theta_mountain = get_theta(xmountain,zmountain,xcar)

delx = 0.1;

xU = xcar + delx;
zU = interp1(xmountain,zmountain,xU);

xL = xcar - delx;
zL = interp1(xmountain,zmountain,xL);

theta_mountain = -atan2(zU-zL,xU-xL);



