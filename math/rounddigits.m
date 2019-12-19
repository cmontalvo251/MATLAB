function out = rounddigits(in,num)

out = num2str(in);

l = find(out == '.');

if l+num <= length(out)
    out = out(1:l+num);
    if num == 0
        out(end) = [];
    end
end

in2 = str2num(out);

if round(in2) == round(in)
    out = num2str(in2);
end


  
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
