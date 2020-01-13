function Feedback_Control()
global A B K
close all
A = [0 1;1 0];
B = [0;1];

%%%Open Loop Eigenvalues
eig(A)

%%%Initial Conditions
x0 = [45*pi/180;0];

%%%Add our feedback control
kp = -20;
kd = -10;
K = [kp kd];

%%%Closed Loop Eigenvalues
eig(A+B*K)

%%%%Let's simulate using State Space
[tSS,xvecSS] = ode45(@DerivativesSS,[0 10],x0);
%%%%Because the sys is 2nd order we need to pull out
%%%x
xSS = xvecSS(:,1); 
plot(tSS,xSS,'m-')


%%%%Now let's code the SS derivatives routine
function dxvecdt = DerivativesSS(t,xvec)
global A B K 
u = K*xvec;

dxvecdt = A*xvec + B*u;
