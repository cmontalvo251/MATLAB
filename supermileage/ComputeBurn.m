function fuel_burn = ComputeBurn(StateOUT,throttle)
parameters

fuel_burn = kburn*throttle;