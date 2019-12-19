function dxdt = Derivatives(xstate,t)
global F

theta = xstate(1);
thetadot = xstate(2);
ycart = xstate(3);
ydotcart = xstate(4);
thetaint = xstate(5);

m = 1;
M = 10;
g = 9.81;
L = 2;
c = 5;
A = m*L*cos(theta)-(M+m)*L*sec(theta);
kp = 1000;
kd = 500;
kI = -200;
thetac = 0;

%%%Psuedo Control
%u = -kp*(theta-thetac)-kd*(thetadot);
%%%Feedback Lin - Without Derivation
%F = A*u + c*thetadot-m*L*thetadot^2*sin(theta)+(M+m)*g*tan(theta);

%%%Straight PID
%F = (-kp*(theta-thetac)-kd*(thetadot))-kI*thetaint;

%%%Feedback Linearization Derived in Class for Non Lin 2017
alfa = -m*L*cos(theta) + (M+m)*L*sec(theta);
bata = (-m*L*sin(theta)*thetadot^2 + (M+m)*g*tan(theta))/alfa;
thetadbldotc = 0;
thetadotc = 0;
thetac = 0;
gam = (thetadbldotc) + kp*((thetac)-(theta)) + kd*((thetadotc)-(thetadot)); 
Ftheta = alfa*(gam - bata);

%%%%Feedback Lin Derived in Class for controlling y
kpy = 100;
kdy = 75;
yddotc = 0;
yc = 0;
ydotc = 0;
gam = yddotc + kpy*(yc - ycart) + kdy*(ydotc - ydotcart);
Fcart = (alfa*cos(theta)/L)*(gam - bata*L*sec(theta)+g*tan(theta));

%F = Fcart;
%F = gam;

%%%Blend Controllers
F = Fcart + Ftheta;

%%%%Feedback Linear with matrix algebra
Mmat = [cos(theta) -L;(M+m) -m*L*cos(theta)];
f = [-g*sin(theta);-m*L*sin(theta)*thetadot^2];
G = [0;1];
gam = (thetadbldotc) + kp*((thetac)-(theta)) + kd*((thetadotc)-(thetadot)); 
%F = (gam - G'*f)/(G'*G);

if abs(F) > 200
    F = sign(F)*200;
end

%%%DEBUGGING
%F = 0;

%%%Dynamics
%thetadbldot = (F-c*thetadot-m*L*thetadot^2*sin(theta)-(M+m)*g*tan(theta))/A;
%Ry = (F+L*thetadbldot*cos(theta)-L*thetadot^2*sin(theta))/(M/m+1);
%ydbldotcart = (1/M)*(F-Ry);
qddot = inv(Mmat)*(f + G*F);
thetaintdot = (theta);
dxdt = [thetadot;qddot(1);ydotcart;qddot(2);thetaintdot];