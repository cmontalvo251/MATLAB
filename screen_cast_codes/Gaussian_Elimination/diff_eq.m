

%%% ydbldot + 2*ydot + 4*y = 0

%%% y(n+1) = y(n) + ydot(n)*deltat

%%%% y(n+1) = [1 deltat]*[y(n) ; ydot(n)]

%%% ydbldot = 

%%% ydot(n+1) = ydot(n) + ydbldot*deltat

%%% ydot(n+1) = ydot(n) + (-2*ydot(n) - 4*y(n))*deltat

%%% ydot(n+1) = [-4*deltat (1-2*deltat)] * [y(n) ; ydot(n)]


%%% let z = [y ydot]

%%% z(n+1) = [1 deltat ; -4*deltat (1-2*delta)] * z(n);

%%% 

clear 
clc
close all

deltat = 0.1;

A = [1 deltat; -4*deltat (1-2*deltat)]
[V,L] = eig(A)
Areconstructed = V*L*inv(V);

n = 1;
y0 = 2;
ydot0 = 0;
z = [y0 ydot0]';
t(1) = 0;
while t < 10
    z(:,n+1) = V*L*inv(V)*z(:,n);
    t(n+1) = t(n) + deltat;
    n = n+1;
end

%%% z1 = V*L*inv(V)*z0
%%% z2 = V*L*inv(V)*z1 = V*L*inv(V)*V*L*inv(V)*z0
%%% z2 = V*L*L*inv(V)*z0
%%% z2 = V*L^2*inv(V)*z0
%%% zK = V*(L^K)*inv(V)*z0
%%% if norm(eigenvalues) > 1 L^K -> infinity

y = z(1,:);
ydot = z(2,:);

plot(t,y)


