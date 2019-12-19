%%%This will take a pdf convert it to a jpg crop it and then export back to
%%%a pdf
function crop(filename,resolution)

resolution = num2str(resolution);

eval(['system(''convertPDF2JPGquick ',filename,' ',resolution,''');'])

in = imread([filename,'.jpg']);

imshow(in);

[r,c] = size(in);

rs = 1;
re = r-600;
cs = 1;
ce = c;

figure()
out = in(rs:re,cs:ce,:);

imshow(out);

flag = input('Good? - 1(yes),2(no) ');

if flag
  imwrite(out,[filename,'.jpg']);
  system(['convert ',filename,'.jpg crop.pdf']);
end



% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
