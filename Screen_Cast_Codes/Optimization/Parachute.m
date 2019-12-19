function Parachute()

close all
clear
clc
format long g

%%%%Plotting Cost vs n and radius
f1 = figure();
nvec = 1:1:10; %%%number of drops
rvec = 0.1:0.01:4; %%%radius in meters
[nmat,rmat] = meshgrid(nvec,rvec);
costmat = computecost(rmat,nmat);
mesh(rmat,nmat,costmat);
hold on
xlabel('Radius(m)')
ylabel('Number of Drops')
zlabel('Cost ($)')

%%%%Plot Impact Velocity Given nvec and rvec
vimpactmat = computeimpact(rvec,nvec);
f2 = figure();
mesh(rmat,nmat,vimpactmat);
hold on
xlabel('Radius (m)')
ylabel('Number of Drops')
zlabel('Velocity(m/s)')

%%%%%Solve the problem
vimpactmat(vimpactmat > 20) = 0;
vimpactmat(vimpactmat ~= 0) = 1;
costmat = costmat.*vimpactmat;
costmat(costmat == 0) = 2e20;
costmin = min(min(costmat))
loc = find(costmat == costmin);
nmin = nmat(loc)
rmin = rmat(loc)
%%%Plot squares on the two meshes from above
figure(f1)
plot3(rmin,nmin,costmin,'ks','MarkerSize',10)
vmin = computeimpact(rmin,nmin);
figure(f2)
plot3(rmin,nmin,vmin,'ks','MarkerSize',10)

%%%%Plot A given n coordinate
n = nmin;
costvec = computecost(rvec,n);
figure()
plot(rvec,costvec)
hold on
plot(rmin,costmin,'ks','MarkerSize',10)
xlabel('Radius(m)')
ylabel('Cost')
title([num2str(n),'= number of drops'])

%%%%Plot Impact velocity Given 1 n coordinate
vimpactvec = computeimpact(rvec,n);
figure()
plot(rvec,vimpactvec)
hold on
plot(rmin,vmin,'ks','MarkerSize',10)
xlabel('Radius(m)')
ylabel('Velocity')

function cost = computecost(r,n)

c0 = 200;
c1 = 56;
c2 = 0.1;
l = sqrt(2).*r;
A = 2*pi*r.^2;
cost = n.*(c0 + c1.*l + c2.*A.^2);

function vimpact = computeimpact(r,n)
global m g c
Mt = 2000;
row = length(r);
col = length(n);
vimpact = zeros(row,col);
%%%Solve for timpact
for idx = 1:length(r)
    for jdx = 1:length(n)
        r0 = r(idx);
        m = Mt/n(jdx);
        alfa = 3;
        g = 9.81;
        A = 2*pi*r0.^2;
        c = alfa*A;
        %altitude(5)
        t0 = 50;
        timpact = fzero(@altitude,t0);
        if timpact < 0
            vimpact(idx,jdx) = 1;
        else
            %zimpact = altitude(timpact);
            vimpact(idx,jdx) = abs(-m*g/c*(1-exp(-c*timpact/m)));
        end
    end
end

function z = altitude(t)
global m g c
z0 = 500;

z = z0 - m*g/c*t + m^2*g/(c^2)*(1-exp(-c*t/m));







