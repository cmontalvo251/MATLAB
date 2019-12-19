function dxdt = filename(t,x)

position = x(1);
velocity = x(2);

F_aero = Aerodynamics(t,x);


F_friction = Friction(t,x);

[Thrust,Fuel_C] = Engine(t,x);


Sum_F = F_aero + F_friciton.....;
    

xddot = Sum_F/m;

dxdt =[];