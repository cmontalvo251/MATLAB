clear
clc
close all

T0 = 0;
tau = 2;
Tc = 100;
k = 5;

timestep = 0.8;
t = 0:timestep:80;

%T = T0*exp(-tau*t) + Tc*(1-exp(-tau*t));

T = 0*t;
Tk4 = 0*t;

plottool(1,'Temperature',18,'Time (sec)','Temperature (F)');

theta = 0;
thetak4 = 0;
next = 0;
for idx = 1:length(t)-1
    %%%Eulers
    Tdot = tau*k*theta - tau*T(idx);
    T(idx+1) = T(idx) + Tdot*timestep;
    %%%RK4
    T1 = tau*k*thetak4 - tau*Tk4(idx);
    T2 = tau*k*thetak4 - tau*(Tk4(idx)+T1*timestep/2);
    T3 = tau*k*thetak4 - tau*(Tk4(idx)+T2*timestep/2);
    T4 = tau*k*thetak4 - tau*(Tk4(idx)+T3*timestep);
    phi = (1/6)*(T1 + 2*T2 + 2*T3 + T4);
    Tk4(idx+1) = Tk4(idx) + phi*timestep;
    %%%%%%%%%%%%%%%%%
    if t(idx) > next
        if abs(T(idx+1) - Tc) > 5
            if T(idx+1) < Tc
                theta = theta + 2;
            elseif Tc > T(idx+1)
                theta = theta - 2;
            end
            if Tk4(idx+1) < Tc
                thetak4 = thetak4 + 2;
            else
                thetak4 = thetak4 - 2;
            end
        end
        next = next + 5;
    end
end

plot(t,T)
hold on
plot(t,Tk4,'r--')
legend('Euler','RK4')