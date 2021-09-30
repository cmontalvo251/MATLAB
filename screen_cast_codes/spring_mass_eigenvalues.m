clear
clc
close all

m1 = 10;
m2 = 10;

k1 = 5;
k2 = 5;
k3 = 5;

M = [m1 0 ; 0 m2];

K = [k1 + k2 -k2 ; -k2 k2 + k3];

A = -inv(M)*K;

PHI = A^(1/2)

[V,L] = eig(PHI)

v1 = V(:,1)
v2 = V(:,2)
l1 = L(1,1)
l2 = L(2,2) 

tout = linspace(0,20,1000);

mode1 = exp(l1*tout);
mode2 = exp(l2*tout);

figure()
plot(tout,mode1)
hold on
plot(tout,mode2,'r-')

%%%3D plot with real and imaginary
figure()
plot3(real(mode1),imag(mode1),tout,'b-')
hold on
plot3(real(mode2),imag(mode2),tout,'r-')
xlabel('real')
ylabel('imag')
zlabel('t')

figure()
plot([0 v1(1)],[0 v1(2)],'b-')
hold on
plot([0 v2(1)],[0 v2(2)],'r-')
axis equal

%%%Part a
figure()
x1mode1 = v1(1)*exp(l1*tout);
x2mode1 = v1(2)*exp(l1*tout);
plot3(x1mode1,x2mode1,tout,'b-')
x1mode2 = v2(1)*exp(l2*tout);
x2mode2 = v2(2)*exp(l2*tout);
hold on
plot3(x1mode2,x2mode2,tout,'r-')
xlabel('x1')
ylabel('x2')
zlabel('t')

%%%%part c
figure()
plot(tout,x1mode1,'b-')
hold on
plot(tout,x2mode1,'b--')
plot(tout,x1mode2,'r-')
plot(tout,x2mode2,'r--')

%%%part b 
figure()
x1mode1 = v1(1)*exp(l1*tout);
x2zeros = x1mode1*0;
plot3(x1mode1,x2zeros,tout,'b-')
x1mode2 = v1(2)*exp(l2*tout);
hold on
plot3(x1mode2,x2zeros,tout,'r-')

%%%Pole Zero Map
figure()
plot(real(L(1,1)),imag(L(1,1)),'bx')
hold on
plot(real(L(1,1)),-imag(L(1,1)),'bx')

plot(real(L(2,2)),imag(L(2,2)),'rx')
plot(real(L(2,2)),-imag(L(2,2)),'rx')
xlim([-1 1])

