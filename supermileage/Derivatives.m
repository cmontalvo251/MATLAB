function dxdt = Derivatives(x_vec,t)
global throttle
global theta
global FuelCons
global Power

global CD

parameters

A = [0 1; 0 0];
B=[0; 1];
position = x_vec(1);
velocity = x_vec(2);
RPM = x_vec(3); 

%COEFFICENTS FOR 100% Throttle
coeff_w100 = [-0.0000   -0.0000    0.0000    2.1131 -490.2254];
coeff_f100=1.0e-04 *[-0.0000;    0.0000;   -0.0000;    0.0008;   -0.1809];
%80% Throttle
coeff_w80= [0.0000   -0.0000    0.0000    1.8713 -606.2577];
coeff_f80= 1.0e-04*[-0.0000; 0.0000; 0.0000; 0.0008; -0.2331];
%60% Throttle
coeff_w60= [ -0.0000   -0.0000    0.0000    1.6570 -691.9148];
coeff_f60= 1.0e-04*[-0.0000; 0.0000; 0.0000; 0.0007; -0.2664];
%40% Throttle
coeff_w40= [-0.0000   -0.0000    0.0000    1.4466 -754.0224];
coeff_f40= 1.0e-04*[-0.0000    0.0000    0.0000    0.0006   -0.2875];
%20% Throttle
coeff_w20= [ -0.0000   -0.0000   -0.0000    1.2533 -806.3799];
coeff_f20= 1.0e-04*[-0.0000; 0.0000; 0.0000; 0.0005; -0.3001];

MPH2MS = (5280)/(3.28*3600);
VL=4*MPH2MS;
VU=24*MPH2MS;

% %%RELAY CONTROLLER 
% if velocity >= 0 && velocity < VU
%    throttle = 100;
% else
%     throttle=0;
% end

%%ALTERNATE RELAY CONTROLLER 
% if velocity >= 0 && velocity < VL
%     throttle = 100;
% elseif velocity >= VU
%     throttle = 0;
% end

%kp=0.2*116;
kp=40;
%%%P CONTROL
VC=20*MPH2MS;
if velocity < VC 
    throttle= kp*(VC-velocity);
else
    throttle=0;
end

% Saturation Block
if throttle>100
    throttle=100;
end

%THROTTLE OUTPUT
if throttle == 0
    Power=0;
else
    Power = polyval(coeff_w100,RPM+2200);
end

if throttle == 100
%%%%    DOES THIS NEED TO BE RPM+2200??
FuelCons= polyval(coeff_f100,RPM+2200); %gal/s
elseif throttle == 0
        FuelCons=0;
       fuelcons=0;
end



% 
% %%THROTTLE OUTPUT
% if throttle == 0
%     Power=0;
%     FuelCons=0;
%     fuelcons=0;
% end
% 

% if throttle == 100
%     DOES THIS NEED TO BE RPM+2200??
%     Power = polyval(coeff_w100,RPM+2200);
%     FuelCons= polyval(coeff_f100,RPM+2200); %gal/s
% end
% 
% if throttle > 0 && throttle <1
%     throttle=1;
% end
% if throttle > 0 && throttle < 100
%     RPMfit = 1000:100:6000;
%  
%     P0 = zeros(1,51);
%     P20 = polyval(coeff_w20,RPMfit);
%     P40 = polyval(coeff_w40,RPMfit);
%     P60 = polyval(coeff_w60,RPMfit);
%     P80 = polyval(coeff_w80,RPMfit);
%     P100 = polyval(coeff_w100,RPMfit);
%     
%     F0 = zeros(1,51);
%     F20 = polyval(coeff_f20,RPMfit);
%     F40 = polyval(coeff_f40,RPMfit);
%     F60 = polyval(coeff_f60,RPMfit);
%     F80 = polyval(coeff_f80,RPMfit);
%     F100 = polyval(coeff_f100,RPMfit);
% 
%     Fuel_M =[F0; F20; F40; F60; F80; F100]';
%     Power_M=[P0; P20; P40; P60; P80; P100]';
%     X_TH =[0 20 40 60 80 100]; %throttle points
%    
%     Power = interp2(X_TH,RPMfit,Power_M,throttle,RPM+2200);
%     FuelCons  = interp2(X_TH,RPMfit,Fuel_M,throttle,RPM+2200);
% end

theta = get_theta(position);
Fgrav = m*g*sin(theta);
Normal = m*g*cos(theta);
Fdrag = 0.5*rho*velocity^2*S*CD;
if abs(velocity) > 0
    Friction = (Normal*mu_f*sign(velocity))+(cb*m*g);
else
    Friction = 0;
end

Fmotor=Power/velocity;

Fmax = 2.7*116; %acceleration*mass
if abs(Fmotor) > Fmax
    Fmotor = sign(Fmotor)*Fmax;
end

% if tk > 10
%       debughere=1;
%     end
    
F = Fmotor - Fgrav -Fdrag - Friction;

dxdt = A*x_vec(1:2) + B*(F/m);
%pause
K = 35;
tau = 0.225;
RPMdot = (throttle*K - RPM)/tau;
dxdt = [dxdt;RPMdot];