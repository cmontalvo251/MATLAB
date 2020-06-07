%%%This will invert a pdf

system('convertPDF2JPG');

files = dir;

for ii = 1:length(files)
    file = files(ii).name;
    if length(file) > 4
        if strcmp(file(end-2:end),'jpg')
            myfile = file;
            ii = length(files)+1;
        end
    end
end

original = imread(myfile);

imshow(original)

%%%rotate 90 degrees

invert = original(end:-1:1,end:-1:1);

imshow(invert)

imwrite(invert,'invert.jpg','jpg');

system('convert invert.jpg Invert.pdf');

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
