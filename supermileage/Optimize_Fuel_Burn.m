purge

parameters

make_terrain

%%%Initial Throttle Vector
throttle_time = 0:1:TFINAL;
throttles = 15*ones(1,length(throttle_time));
%throttles = [15 11 3];
[time,StateOUT,ControlOUT] = car(xmountain,zmountain,throttles,throttle_time);
fuel_burn0 = Compute_Fuel_Burn(StateOUT)
throttle_delta = 10;

while throttle_delta > 1
    disp(['Throttle Delta = ',num2str(throttle_delta)])
    improvement_made = 1;
    ctr = 1;
    while improvement_made
        improvement_made = 0;
        disp(['Optimization = ',num2str(ctr)])
        ctr = ctr + 1;
        [time,StateOUT,ControlOUT] = car(xmountain,zmountain,throttles,throttle_time);
        fuel_burn0 = Compute_Fuel_Burn(StateOUT);
        for loc = 1:length(throttles)
            disp(['Iteration = ',num2str(loc),' out of ',num2str(length(throttles))])
            %%%%Reduce Throttle
            throttles(loc) = throttles(loc) - throttle_delta;
            %%%%Compute Simulation
            [time,StateOUT,ControlOUT] = car(xmountain,zmountain,throttles,throttle_time);
            %%%%Compute Fuel Burn
            [fuel_burn,umin] = Compute_Fuel_Burn(StateOUT);
            if fuel_burn < fuel_burn0 && umin >= VL
                fuel_burn0 = fuel_burn
                improvement_made = 1;
            else
                throttles(loc) = throttles(loc) + throttle_delta;
            end
        end
    end
    throttle_delta = throttle_delta - 1;
end
throttles
[time,StateOUT,ControlOUT] = car(xmountain,zmountain,throttles,throttle_time);
        
plotStuff