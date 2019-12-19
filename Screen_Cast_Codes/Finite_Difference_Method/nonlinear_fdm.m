function nonlinear_fdm()

clear
clc
close all

%%% u'' - u' + u^2 = c^2(x) - s(x) + c(x) = f(x)

%%% u'' = ( u(i+1) - 2*u(i) + u(i-1) )/dx^2

%%% u' =  ( u(i+1) - u(i-1) ) / (2*dx) - left and right boundary conditions

%%% f(i) = f(x(i))

%%% Discretize the bar
N = 1000;
L = 10; 

x_vec = linspace(0,L,N);
dx = x_vec(2) - x_vec(1);

%%%Actual Solution
u_actual = -cos(x_vec);
uprime_actual = sin(x_vec);

%%%% Integrate the equations from the left using the left boundary
%%%% condition
zL_approx = [0*u_actual;0*u_actual];
zL_approx(:,1) = [u_actual(1);uprime_actual(1)];

for idx = 1:length(x_vec)-1
   %%% z(i+1) = z(i) + zprime(i)*dx;
   zi = zL_approx(:,idx);
   xi = x_vec(idx);
   k1 = derivs(zi,xi);
   k2 = derivs(zi+k1*dx/2,xi+dx/2);
   k3 = derivs(zi+k2*dx/2,xi+dx/2);
   k4 = derivs(zi+k3*dx,xi+dx);
   phi = (1/6)*(k1+2*k2+2*k3+k4);
   zL_approx(:,idx+1) = zi + phi*dx;
end
uL_approx = zL_approx(1,:);

%%% Integrate from the right using the right boundary conditions
zR_approx = [0*u_actual;0*u_actual];
zR_approx(:,end) = [u_actual(end);uprime_actual(end)];

for idx = length(x_vec):-1:2
   %%% z(i-1) = z(i) - zprime(i)*dx;
   zi = zR_approx(:,idx);
   xi = x_vec(idx);
   k1 = derivs(zi,xi);
   k2 = derivs(zi-k1*dx/2,xi-dx/2);
   k3 = derivs(zi-k2*dx/2,xi-dx/2);
   k4 = derivs(zi-k3*dx,xi-dx);
   phi = (1/6)*(k1+2*k2+2*k3+k4);
   zR_approx(:,idx-1) = zi - phi*dx;
end
uR_approx = zR_approx(1,:);

%%% Average them together using a weighted average
weightL = 1-(x_vec/L);
weightR = 1-weightL;
figure();
plot(x_vec,weightL)
hold on
plot(x_vec,weightR,'r--')
legend('Left Weight','Right Weight')
u_approx = weightL.* uL_approx + weightR.* uR_approx; %%% perfect average

%%%

figure()
plot(x_vec,u_actual)
hold on
plot(x_vec,uL_approx,'g--')
plot(x_vec,uR_approx,'m--')
plot(x_vec,u_approx,'r--')
xlabel('X (m)')
ylabel('U (nd)')
legend('Actual','Left','Right','Averaged')

function zprime = derivs(z,x)

%%% z = [u,u']
u = z(1);
uprime = z(2);

%%% z' = [u',u'']
%%% z' = [u',f(x) + u' - u^2]

zprime = [uprime;f(x) + uprime - u^2];

function out = f(x)

out = (cos(x)).^2 - sin(x) + cos(x);

