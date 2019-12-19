function [pressure_load,mat] = bridge_material(mass)

g = 9.81;

truck_load = mass*g; %%%units of force
truck_area = 1; %%sq meters

pressure_load = truck_load/truck_area;

%%%Data file with Yield loading of different materials
wood = 40;
aluminium = 14000; %%SI pressure (Pascals)

if pressure_load > wood
    if pressure_load > aluminium 
        mat = 'unobtainium';
        disp('Use a different material than Aluminum')
    else
        mat = 'aluminum';
        disp('Aluminum is acceptable')
    end
else
    mat = 'wood';
    disp('Use wood')
end
