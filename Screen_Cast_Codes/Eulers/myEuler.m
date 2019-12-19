function myEuler(deltat)


%%%Specify n's and y's

n = 1;

%%%Specifying initial conditions
y = 2;
ydot = -2;

z = [y;ydot];
t = 0;

A = [1 deltat;-4*deltat 1-2*deltat];
det(A)
a = eig(A)
l1 = a(1);
l2 = a(2);

norm(l1)
norm(l2)

while t < 100
   z(:,n+1) = A*z(:,n);
   t(n+1) = t(n) + deltat;
   n = n + 1;
end

y = z(1,:);
close all
plot(t,y)
