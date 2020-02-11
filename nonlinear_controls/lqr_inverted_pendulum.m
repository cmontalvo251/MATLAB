function lqr_inverted_pendulum()
global K A B Q R N
clc
close all

%%%Run the LQR controller
g = 9.81;
L = 2;
m = 0.5;
a1 = g/L;
b1 = 1/(m*L^2);
A = [0 1;a1 0];
B = [0;b1];
for q = 1
    q1 = q;
    q2 = q;
    Q = [q1 0;0 q2]
    r = 1;
    R = r;
    N = 0;
    [K,S,e] = lqr(A,B,Q,R,N);
    K
    S 
    e
    [myK,myS,mye] = mylqr(r,b1,a1,q1,q2);
    myK
    myS
    mye
    tspan = [0 10];
    xinitial = [45*pi/180;0];
    [tout,xout] = ode45(@Derivatives,tspan,xinitial);
    hold on
    plot(tout,xout(:,1))
end

function [K,S,e] = mylqr(r,b1,a1,q1,q2)
%%%Solve for s3
abar = 1;
bbar = -2*r*a1/(b1^2);
cbar = -r*q1/(b1^2);
s3 = -bbar/2 + 0.5*sqrt(bbar^2 - 4*abar*cbar);
%s3_1 = -bbar/2 - 0.5*sqrt(bbar^2 - 4*abar*cbar);
%s3_sols = [s3_0 s3_1]

%%%Solve for s2
s2 = sqrt((2*s3*r + q2*r)/b1^2);
%s2_1 = sqrt((2*s3_1*r + q2*r)/b1^2);
%s2_2 = -sqrt((2*s3_0*r + q2*r)/b1^2);
%s2_3 = -sqrt((2*s3_1*r + q2*r)/b1^2);
%s2_sols = [s2_0 s2_1 s2_2 s2_3]

%%%Solve for s1
s1 = b1^2/r*s3*s2-a1*s2;
%s1_1 = b1^2/r*s3_0*s2_1-a1*s2_1;
%s1_2 = b1^2/r*s3_0*s2_2-a1*s2_2;
%s1_3 = b1^2/r*s3_0*s2_3-a1*s2_3;
%s1_4 = b1^2/r*s3_1*s2_0-a1*s2_0 - these are repeated 
%s1_5 = b1^2/r*s3_1*s2_1-a1*s2_1 -- and not needed
%s1_6 = b1^2/r*s3_1*s2_2-a1*s2_2
%s1_7 = b1^2/r*s3_1*s2_3-a1*s2_3
%s1_sols = [s1_0 s1_1 s1_2 s1_3];

%%%%Plug in for S
B = [0;b1];
%for s3 = s3_sols
%    for s2 = s2_sols
%        for s1 = s1_sols
            S = [s1 s3;s3 s2];
            K = (1/r)*(B'*S);
%        end
%    end
%end
A = [0 1;a1 0];
e = eig(A-B*K);


function dxdt = Derivatives(t,x)
global K A B

%%%LQR
u = -K*x;

%%%PID
theta = x(1);
thetadot = x(2);
thetac = 0;
thetacdot = 0;
kp = 100;
kd = 10;
%u = kp*(thetac - theta) + kd*(thetacdot - thetadot);

dxdt = A*x + B*u;