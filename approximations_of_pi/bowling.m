function mypi = bowling(N)
clc

m = 10;
M = 16*(100^N)*m;
x = m/M;
%theta = (1-x)/(1+x);

%%%State Transition Matrix
%A = [theta 2*x/(1+x);-2/(x+1) theta];
%A = [theta 2*x*theta/(1-x);-2*theta/(1-x) theta];
%[V,L] = eig(A);
%U = inv(V);

%%%Eigenvalues
%s1 = theta + 2*sqrt(x)/(1+x)*1i;
%s2 = theta - 2*sqrt(x)/(1+x)*1i;
%L = [s1 0 ;0 s2];
%%%Eigenvectors
%v1 = [sqrt(x)*1i/sqrt(1+x);1/sqrt(1+x)];
%v2 = [-sqrt(x)*1i/sqrt(1+x);1/sqrt(1+x)];
%V = [v1,v2];
%%%Inverse of Eigenvectors
%u1 = [-sqrt(1+x)*1i/(2*sqrt(x));sqrt(x+1)*1i/(2*sqrt(x))];
%u2 = [sqrt(x+1)/2;sqrt(x+1)/2];
%U = [u1,u2];
%%%DeMoivres Principle
%calfa = theta;
%salfa = 2*sqrt(x)/(1+x);
%alfa = atan2(salfa,calfa);
alfa = atan2(2*sqrt(x),1-x);

%%%Initial Conditions
u = 1;
v = 0;
uv0 = [u;v];
uvN = uv0;
uN = u;
mypi = -1;

%%%EXPLICIT VERSION
2*alfa
10^-N
k = tan(10^-N/2);
a = 1;
b = -(2+4/k^2);
c = 1;
x
xguess = (-b - sqrt(b^2-4*a*c))/(2*a)
mass_ratio = 1/xguess
mypi = floor(pi/(2*alfa))

%while uN > 0
%    mypi = mypi + 1;
    
    %%%DEMOIVRES SIMPLIFICATION
    %uN = u*cos((mypi+1)*alfa);
    %s1N = cos((mypi+1)*alfa) + 1i*sin((mypi+1)*alfa);
    %s2N = cos((mypi+1)*alfa) - 1i*sin((mypi+1)*alfa);
    %s1N = (calfa+1i*salfa)^(mypi+1);
    %s2N = (calfa-1i*salfa)^(mypi+1);
    %uN = (u/2)*(s1N + s2N);
    %uN = u*cos((mypi+1)*alfa);
    
    %%%SEMI EXPLICIT FORM
    %uN = (u/2)*(s1^(mypi+1) + s2^(mypi+1));
    
    %%%SINGLE ROW FORM
    %uN = (v1(1)*u1(1)*s1^(mypi+1) + v2(1)*u1(2)*s2^(mypi+1))*u;
    
    %%%%%EIGENVECTOR FORM
    %uvN = V*L^(mypi+1)*U*uv0;
    
    %%%%STATE TRANSITION FORM
    %uvN = (A^(mypi+1))*uv0;
    
    %%%%%MATRIX FORM
    %uv0 = A*uv0;
    
    %%%%SINGLE PHASE COLLISION
    %utemp = theta*u + 2*x/(1+x)*v;
    %v = theta*v - 2*u/(x+1);
    %u = utemp;
    
    %%%%TWO PHASE COLLISIONS
    %%%Collision between little and big ball
    %utemp = theta*u + 2*x/(1+x)*v;
    %v = 2*u/(x+1) - theta*v;
    %u = utemp;
    %%%Colliding with Wall
    %v = -v;
%end

function [KE,P] = computeKE_P(u,v)

KE = 0.5*M*u^2 + 0.5*m*v^2;KE = 0.5*M*u^2 + 0.5*m*v^2;
P = M*u + m*v;
