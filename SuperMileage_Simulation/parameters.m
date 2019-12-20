%Parameters for 2015 Endurance USA Supermileage vehicle

%%%Constants
    g = 9.81;      %m/s^2      (Gravitational Constant)
    rho = 1.171; %%%kg/m^3     (Density of Air)
    
%%%Vehicle Parameters
    Lcar = 2.5;    %m          (Vehicle Length)
    h = 0.762;     %m          (Vehicle Height)
    width = 0.762; %m          (Vehicle Width)
    S = h*width;   %m^2        (Projected Frontal Area)
    mv=  53;       %kg         (Mass of Vehicle)
    md=  63;       %kg         (Mass of Driver)
    m = mv+md;     %kg         (Total Vehicle Mass)
    %CD = 0.145;    %           (Drag Coefficient)
    mu_f = 0.002;  %           (Friction Coefficient)
    %rw=  0.254;   %m          (Wheel Radius) 
    %gr=  8;       %           (Gear Ratio)
    %rb = 0.0254;  %m          (Bearing Radius)
    cb=  0.003;    %           (Bearing coefficient of friction)