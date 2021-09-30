function computers_out = Process_Comps(computers_in)
%%%This function header is the only way to transport information from the
%%%workspace to the function space.


N = length(computers_in); %%%N is the length or the number of elements in computers_in

for idx = 1:N   %%How many loops do I want? N. What is N?
    
    %%%Do stuff
    computers_in(idx).cpu2 = computers_in(idx).cpu/2; %%%2 is arbitrary and chosen by Weston
    %%%Why cpu2? - Creating a new field in the struture
    
    %%%Break line down
    %%%Computers_in is what type of variable? - structure
    %%%%What is cpu - field
    %%%%computers_in(idx).cpu -> pulls the field out of the structure for
    %%%%the specific index that I am at.
    
        
    
end

%%%Passing the local version of the structure computers to the workspace
computers_out = computers_in;
