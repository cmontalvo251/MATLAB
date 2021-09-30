function newtons_method()
clc
close all
global fcalls

x1 = -2:0.1:2;
x2 = x1;
[xx2,xx1] = meshgrid(x2,x1);
zz1 = 0*xx1;
zz2 = 0*xx1;

for idx = 1:length(x1)
    for jdx = 1:length(x2)
        xij = [x1(idx);x2(jdx)];
        out = f(xij);
        zz1(idx,jdx) = out(1);
        zz2(idx,jdx) = out(2);
    end
end

mesh(xx1,xx2,zz1)
hold on
mesh(xx1,xx2,zz2)

x = [1 2]';
fcalls = 0;
itermax = 1000;

for idx = 1:itermax
    s = -inv(Jnumerical(x))*f(x);
    xn = x + s;
    %fx = f(x);
    %fxn = f(xn);
    %plot3([x(1) xn(1)],[x(2) xn(2)],[fx(1) fxn(1)],'r-*','MarkerSize',20)
    %plot3([x(1) xn(1)],[x(2) xn(2)],[fx(2) fxn(2)],'g-*','MarkerSize',20)
    x = xn;
end
fcalls

x = [1 2]';
B = J(x);

fcalls = 0;

for idx = 1:itermax
    s = -inv(B)*f(x);    
    xn = x + s;
    y = f(xn)-f(x);
    %fx = f(x);
    %fxn = f(xn);
    if norm(s'*s) > 1e-4
        B = B + ((y-B*s)*s')/(s'*s);
    end
    %plot3([x(1) xn(1)],[x(2) xn(2)],[fx(1) fxn(1)],'r-s','MarkerSize',20)
    %plot3([x(1) xn(1)],[x(2) xn(2)],[fx(2) fxn(2)],'g-s','MarkerSize',20)
    x = xn;
end

fcalls

function out = f(x)
global fcalls

fcalls = fcalls + 1;
x1 = x(1);
x2 = x(2);

out = [x1+2*x2-2;
    x1^2+4*x2^2-4];

function out = J(x)
x1 = x(1);
x2 = x(2);
out = [1 2 ; 2*x1 8*x2];

function out = Jnumerical(x)
dx = 0.1;
out = [0;0];
f0 = f(x);
for idx = 1:2
    x(idx) = x(idx)+dx;
    out(:,idx) = (f(x)-f0)/dx;
    x(idx) = x(idx)-dx;
end


