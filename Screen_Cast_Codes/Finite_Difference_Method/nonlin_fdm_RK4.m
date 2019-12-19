function nonlin_fdm_RK4()

clc
close all

%%%% u'' - u' + u^2 = cos^2(x) - sin(x) + cos(x) = f(x)

%%% u '' = f + u' - u^2

%%% let z = [u,u'] then z' = [u',u''] and integrate forward
N = 10000;
L = 10;

x = linspace(0,L,N);
dx = x(2) - x(1);
f = (cos(x)).^2 - sin(x) + cos(x);

%%%Actual Solution
u_actual = -cos(x);
u_prime_actual = sin(x);

%%%Propogate forward from left
zL_approx = [0*u_actual;0*u_actual];

%%%ICs - Use actual solution as initial conditions
zL_approx(:,1) = [u_actual(1);u_prime_actual(1)];

for idx = 1:length(x)-1
    %%%RK4
    zi = zL_approx(:,idx);
    xi = x(idx);
    k1 = D(zi,xi);
    k2 = D(zi+k1*dx/2,xi+dx/2);
    k3 = D(zi+k2*dx/2,xi+dx/2);
    k4 = D(zi+k3*dx,xi+dx);
    phi = (1/6)*(k1 + 2*k2 + 2*k3 + k4);
    zL_approx(:,idx+1) = zi + phi*dx;
end

%%%Propogate backwards from right
zR_approx = [0*u_actual;0*u_actual];

%%%ICs - Use actual solution as initial conditions
zR_approx(:,end) = [u_actual(end);u_prime_actual(end)];

for idx = length(x):-1:2
    %%%RK4
    zi = zR_approx(:,idx);
    xi = x(idx);
    k1 = D(zi,xi);
    k2 = D(zi-k1*dx/2,xi-dx/2);
    k3 = D(zi-k2*dx/2,xi-dx/2);
    k4 = D(zi-k3*dx,xi-dx);
    phi = (1/6)*(k1 + 2*k2 + 2*k3 + k4);
    zR_approx(:,idx-1) = zi - phi*dx;
end

uL_approx = zL_approx(1,:);
uR_approx = zR_approx(1,:);

%%%Blend Solutions using weighted interpolation
weight1 = 1-x/L;
weight2 = 1-weight1;
u_approx = weight1.*uL_approx + weight2.*uR_approx;

h1 = figure();
ax1 = gca;
hold on
xlabel('X (m)')
ylabel('U (nd)')
plot(ax1,x,u_actual,'b-')
%plot(ax1,x,uL_approx,'g--')
%plot(ax1,x,uR_approx,'r--')
plot(ax1,x,u_approx,'r--')
%legend('Actual','Left Integrator','Right Integrator','Blended Solution')
legend('Actual','Blended Solution')

figure()
plot(x,abs(u_actual-u_approx))

function zprime = D(z,x)
u = z(1);
uprime = z(2);
udblprime = f(x) + uprime - u^2;
zprime = [uprime;udblprime];

function out = f(x)

out = (cos(x)).^2 - sin(x) + cos(x);