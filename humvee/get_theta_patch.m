function theta_mountain = get_theta_patch(centroidsxy,xp,yp,zp,xi,yi)

delx = 0.1;

xU = xi + delx;
zU = interppatch(centroidsxy,xp,yp,zp,xU,yi);

xL = xi - delx;
zL = interppatch(centroidsxy,xp,yp,zp,xL,yi);

theta_mountain = -atan2(zU-zL,xU-xL);




