%%%Hockey
%%%vdot = -c/m*v
function rk4_first_order()
clc
close all

v0 = 10;
deltat = 1/5; %%%If you make this bigger than 2/5 Euler's 
%method will blow up but RK4 will be ok because it is a 
%higher order method (4th order to be exact)
tfinal = 10; %%seconds
t_vec = 0:deltat:tfinal;
v_vec = zeros(1,length(t_vec));
v_Euler_vec = zeros(1,length(t_vec));
v_vec(1) = v0;
v_Euler_vec(1) = v0;
for n = 1:length(t_vec)-1
    k1 = f(v_vec(n));
    k2 = f(v_vec(n)+k1*deltat/2);
    k3 = f(v_vec(n)+k2*deltat/2);
    k4 = f(v_vec(n)+k3*deltat);
    phi = (1/6)*(k1 + 2*k2 + 2*k3 + k4);
    v_vec(n+1) = v_vec(n) + phi*deltat;    
    v_Euler_vec(n+1) = v_Euler_vec(n) + f(v_Euler_vec(n))*deltat;
end

plot(t_vec,v_vec)
hold on
m = 1;
c = 5;
v_vec_actual = v0*exp(-c/m*t_vec);
plot(t_vec,v_vec_actual,'r-')
plot(t_vec,v_Euler_vec,'g-')
legend('RK4','Actual','Euler')

%figure()
%plot(t_vec,abs(v_vec_actual-v_vec))

function vdot = f(v)
m = 1;
c = 5;
parameters
vdot = -c/m*v;

