function flipphoto(filename)

A = imread(filename);

B = A(end:-1:1,end:-1:1,:);

imwrite(B,'invert.jpg','jpg');

disp('File written as invert.jpg');
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
