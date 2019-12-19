function linesofcode(directory,ext_type)
%purge

%directory = {'Dynamic_Model','/home/carlos/Dropbox/BlackBox/c++'};
numlines = 0;
for idx = 1:length(directory)
    d = dir(directory{idx});
    for n = 1:length(d)
        name = d(n).name;
        if length(name) > 2
            tdot = find(name=='.',1);
            ext = name(tdot:end);
            %if strcmp(ext,'.h') || strcmp(ext,'.cpp')
	    if strcmp(ext,ext_type)
                numlines = numlines + getlines([directory{idx},'/',name]);
            end
        end
    end
end
numlines
