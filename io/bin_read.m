function [v1_out,v2_out,v3_out,v4_out] = bin_read(filename)

fid = fopen(filename,'r');
v1_out=[];
v2_out=[];
v3_out=[];
v4_out=[];
loopnum=1;
while true
    try
       v1 = get_matrix(fid);
       v2 = get_matrix(fid);
       v3 = get_matrix(fid);
       v4 = get_matrix(fid);

    catch
        break;
    end
    if loopnum==1
        prev_last_time = v1(end);
        v1_out=v1;
        v2_out=v2;
        v3_out=v3;
        v4_out=v4;
        loopnum=loopnum+1;
    else
        this_first_time = v1(1);
        if this_first_time==prev_last_time
            st_in2=2;
        else
            st_in2=1;
        end
        v1_out=[v1_out;v1(st_in2:end,:)];
        v2_out=[v2_out;v2(st_in2:end,:)];
        v3_out=[v3_out;v3(st_in2:end,:)];
        v4_out=[v4_out;v4(st_in2:end,:)];
        prev_last_time = v1(end);
        loopnum=loopnum+1;
    end
    %loopnum=loopnum+1
    %whos v*_*
end
fclose(fid);
    function v = get_matrix(fid)
        size1 = fread(fid,1,'double');
        size2 = fread(fid,1,'double');
        numbytes = fread(fid,1,'double');
        numel_in_matrix = size1*size2;
        bytes_per_entry = numbytes/numel_in_matrix;
        if bytes_per_entry ==4
            typestr='single';
        else
            typestr='double';
        end
        v = fread(fid,numel_in_matrix,typestr);
        v = reshape(v,size1,size2);
    end

end