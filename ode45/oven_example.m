function oven_example()
global wait Qdot

wait = 0
Qdot = 0

% Tddot = -tau * (T-T_inf) + Qdot

close all

tout = linspace(0,100,1000);
zinitial = [72;0];
[tout,zout] = ode45(@Derivatives,tout,zinitial);

plot(tout,zout(:,1))

grid on
xlabel('Time (sec)')
ylabel('Temperature (F)')

%##I'd also like to plot control input
qdot_out = zeros(length(tout),1);
for idx = 1:length(tout)
    zdot = Derivatives(tout(idx),zout(idx,:));
    qdot_out(idx) = Qdot;
end
    
figure()
plot(tout,qdot_out)
grid on
xlabel('Time (sec)')
ylabel('Qdot (BTU)')

function zdot = Derivatives(t,z)
global wait Qdot

Tdot = z(2);
T = z(1);
zeta = 1;
wn = 0.1;
T_inf = 72 ;
T_bake = 350;
%##Bang bang control
threshold = 10;
if wait == 0
    if T < (T_bake+threshold)
        Qdot = 400;
    else
        wait = 1;
        Qdot = 0;
    end
else
    if T < (T_bake-threshold)
        wait = 0;
        Qdot = 400;
    else
        Qdot = 0;
    end
end
%##Proportional Control
%kp = -10;
%Qdot = kp*(T-T_bake);
%if Qdot > 400
%    Qdot = 400;
%end

Tddot = -wn^2 * (T-T_inf) - 2*zeta*wn*Tdot + wn^2*Qdot;

zdot = [Tdot;Tddot];