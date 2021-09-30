clear
clc
close all
%%%% u'' - u' + u^2 = cos^2(x) - sin(x) + cos(x) = f(x)

N = 1000;
L = 10;

x = linspace(0,L,N);

dx = x(2) - x(1);
f = (cos(x)).^2 - sin(x) + cos(x);


%%%Actual Solution
u_actual = -cos(x);

%%%Check and make sure exact solution is correct
usecond_deriv = 0*x;
ufirst_deriv = 0*x;
for idx = 2:length(x)-1
    usecond_deriv(idx) = (u_actual(idx+1)-2*u_actual(idx)+u_actual(idx-1))/(dx^2);
    ufirst_deriv(idx) = (u_actual(idx+1)-u_actual(idx-1))/(2*dx);
end

f_approx = usecond_deriv - ufirst_deriv + u_actual.^2;

h2 = figure();
ax2 = gca;
plot(x,f)
hold on
plot(x,f_approx,'r--')
xlabel('X (m)')
ylabel('Forcing Function')
legend('Actual Forcing Function','Numerical Approximation')

%%%%Test Algorithm to see if solution satisfies it

%%% 2dx^3 ui^2 - 4dx ui + 2dx ui+1 + 2dx ui-1 - dx^2 (ui+1 - ui-1) - 2dx^3 fi = 0
u_test = 0*x;
a = 2*dx^3;
b = -4*dx;
for idx = 2:length(x)-1
    ci = 2*dx*u_actual(idx+1) + 2*dx*u_actual(idx-1) - (dx^2)*(u_actual(idx+1) - u_actual(idx-1)) - 2*dx^3*f(idx);
    u_test(idx) = a*u_actual(idx)^2 + b*u_actual(idx) + ci;
end
figure()
plot(x,u_test)
xlabel('X (m)')
ylabel('Test - Should be zero')

%%%%Create Initial condition guess. Assume zero since we don't know any
%%%%better
u_approx = 0*u_actual;

%%%%Use actual solution for BC's since these are technically known for
%%%%problems like this
u_approx(1) = u_actual(1);
u_approx(end) = u_actual(end);

%%%%Since algorithm works and we know the solution is -cos(x) let's try the
%%%%algorithm

h1 = figure();
ax1 = gca;
plot(ax1,x,u_actual)
hold on
xlabel('X (m)')
ylabel('U (nd)')


for n = 1:10000
    for idx = 2:length(x)-1
        c = 2*dx*u_approx(idx+1) + 2*dx*u_approx(idx-1) - (dx^2)*(u_approx(idx+1) - u_approx(idx-1)) - 2*dx^3*f(idx);
        %a*u_approx(idx)^2 + b*u_approx(idx) + ci = 0
        %Use the equation above to solve for u_approx
        sig = -b/(2*a);
        omega = sqrt(b^2-4*a*c)/(2*a); 
        %%%To choose the best solution we first omit imaginary solutions
        if real(omega) == 0
           u_approx(idx) = sig; 
        else
           %%%Then we simply pick the solution closest to the current guess
           sol1 = sig+omega;
           diff1 = abs(u_approx(idx)-sol1);
           sol2 = sig-omega;
           diff2 = abs(u_approx(idx)-sol2);
           if diff1 > diff2
               u_approx(idx) = sol1;
           else
               u_approx(idx) = sol2;
           end
        end
    end
end
%%%Plot solution while integrating
cla
title(num2str(n))
plot(ax1,x,u_actual,'b-')
plot(ax1,x,u_approx,'r--')
drawnow
legend('Actual','Numerical')




