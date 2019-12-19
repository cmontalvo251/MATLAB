function computer_out = DispComputer(computer_in)
%%%This takes in 1 variable and it is type structure
%%%This outputs 1 variable and it is type structure

num_computer = length(computer_in);

for idx = 1:num_computer
   name = computer_in(idx).name; %%%Save local version of name
   cpu = computer_in(idx).cpu; 
   
   bob = [name,' has a cpu with GHz: ',num2str(cpu)];
   
   disp(bob)
   
   %%%Let's convert cpu to Hz
   cpuHz = cpu*(10^9);
   
   %%%Add a field;
   computer_in(idx).cpuHz = cpuHz;

    
end



%%%%Pass the local version of the structure back to the workspace
computer_out = computer_in;