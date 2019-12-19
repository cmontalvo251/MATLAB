clear
clc
close all

tau = 0.4;
Tc = 110;

timestep = 6;
t_vec = 0:timestep:20;

Ta_vec = Tc*(1-exp(-tau*t_vec));

plot(t_vec,Ta_vec)


%%%%Euler's method
Tn_vec(1) = 0;
for n = 1:length(t_vec)-1
    Tndot = tau*(Tc-Tn_vec(n));
    Tn_vec(n+1) = Tn_vec(n) + Tndot*timestep;
end

hold on
plot(t_vec,Tn_vec,'r-')
legend('Analytical','Euler(Numerical)')


