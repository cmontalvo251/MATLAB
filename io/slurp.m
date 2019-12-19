function out_mat = slurp(filename)

%%%Read in entire file
fid = fopen(filename);
this_line = 0;
out_mat = {};
while this_line ~= -1
    this_line = fgetl(fid);
    if isempty(this_line)
        this_line = 0;
    elseif this_line ~= -1
      out_mat = [out_mat;this_line];
    end
end
fclose(fid);
