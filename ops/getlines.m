function numlines = getlines(name)
name
fid = fopen(name);
this_line = 0;
numlines = 0;
while this_line ~= -1
    this_line = fgetl(fid);
    numlines = numlines + 1;
    if isempty(this_line)
        this_line = 0;
    end
end
numlines
fclose(fid);
