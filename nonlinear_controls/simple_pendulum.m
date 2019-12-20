clear
clc
close all
format short

global g L

g = 3.1;
L = 20;

%%%OPEN LOOP CONTROL
A = [0 1;-g/L 0];
B = [0 ;1];
C = [1 0];
D = 0;
[v,s] = eig(A)

pzmap(A,B,C,D)

%%%plot x as a function of time
t = linspace(0,100,100);
x0 = [10*pi/180;2];
x = zeros(2,length(t));
for idx = 1:length(t)
    x(:,idx) = expm(A*t(idx))*x0;
end
figure()
plot(t,x)

%%%%CLOSED LOOP CONTROL
kp = 1000000;
kd = 2;
K = [kp kd];
[sCL,vCL] = eig(A-B*K)
%%%plot x as a function of time
xCL = zeros(2,length(t));
u = zeros(1,length(t));
for idx = 1:length(t)
    xCL(:,idx) = expm((A-B*K)*t(idx))*x0;
    u(idx) = -K*xCL(:,idx);
end
figure()
plot(t,xCL)
figure()
plot(t,u)


