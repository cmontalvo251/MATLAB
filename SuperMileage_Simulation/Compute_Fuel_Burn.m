function [fuel_burn,umin] = Compute_Fuel_Burn(StateOUT)

parameters

xcar = StateOUT(1,:);
throttle = StateOUT(3,:);
ucar = StateOUT(2,:);

FinishLoc = find(xcar > xFinish,1);
if isempty(FinishLoc)
    fuel_burn = realmax;
    umin = 0;
else
    fuel_burn_vec = ComputeBurn(StateOUT,throttle);
    fuel_burn = sum(fuel_burn_vec(1:FinishLoc))*timestep;
    umin = min(ucar(1:FinishLoc));
end
