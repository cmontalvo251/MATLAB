purge

directory = '~/Other/Wheels/Nov_8/STL_Files/';

files = dir(directory);

plottool(1,'Wheel',12)
for ii = 3:length(files)
  name = files(ii).name
  [x,y,z] = stlread([directory,name]);
  eval(['save ~/Desktop/',name(1:end-4)])
end
