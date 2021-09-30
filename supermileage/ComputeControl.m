function throttle_command = ComputeControl(State,throttle_command_prev)
parameters

%x = State(1);
u = State(2);
%throttle = State(3);

%%%Control of Throttle

%%%%RELAY CONTROLLER
%if u < VL + offset
%    throttle_command = 100;
%else
%    throttle_command = 0;
%end

%%%%Slight Modification
%if throttle_command_prev == 100 && u < VU
%    throttle_command = 100;
%end
    
%%%Proportional Controller
if u < VC
    throttle_command = kp*(VC-u);
else
    throttle_command = 0;
end


%%%%SATURATION BLOCK
if throttle_command > 100
    throttle_command = 100;
end