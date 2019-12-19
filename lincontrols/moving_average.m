function out = moving_average(in,s)

if s > 1
    s = 1;
    disp('Warning s must be less than 1')
end
if s < 0 
    s = 0;
    disp('Warning s must be greater than 0')
end

if s == 1
    out = 0*in;
elseif s == 0
    out = in;
else
    out = 0*in;
    for idx = 2:length(in)
        out(idx) = s*out(idx-1) + (1-s)*in(idx);
    end
end
        


    