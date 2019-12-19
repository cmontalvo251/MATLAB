function bin_write(fid,v1,v2,v3,v4)
%
% function for writing a matrix to a file in binary format
% 8 bytes per double
% 4 bytes per single
% assume everything is being written in sigle precision
% The file is written in chunks
% 3 variables
% [v1,v2,v3] = b_read(fid,)
%  b_write(fid,v1,v2,v3)

sv_whos = whos('v1');
sv_size = sv_whos.size;
sv_bytes = sv_whos.bytes;
sv_class = sv_whos.class;
fwrite(fid,sv_size,'double');
fwrite(fid,sv_bytes,'double');
fwrite(fid,v1,sv_class);

sv_whos = whos('v2');
sv_size = sv_whos.size;
sv_bytes = sv_whos.bytes;
sv_class = sv_whos.class;
fwrite(fid,sv_size,'double');
fwrite(fid,sv_bytes,'double');
fwrite(fid,v2,sv_class);

sv_whos = whos('v3');
sv_size = sv_whos.size;
sv_bytes = sv_whos.bytes;
sv_class = sv_whos.class;
fwrite(fid,sv_size,'double');
fwrite(fid,sv_bytes,'double');
fwrite(fid,v3,sv_class);

sv_whos = whos('v4');
sv_size = sv_whos.size;
sv_bytes = sv_whos.bytes;
sv_class = sv_whos.class;
fwrite(fid,sv_size,'double');
fwrite(fid,sv_bytes,'double');
fwrite(fid,v4,sv_class);
