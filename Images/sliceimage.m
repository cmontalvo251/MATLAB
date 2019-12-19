function [left,right,shift] = sliceimage(im,x1,x2,fall)
close all

[r,c,d] = size(im);

%figure()
%imshow(im)

slope = (x2-x1)/(r-1);

y = 1:r;

x = x1 + slope.*(y-1);

left = im;
right = im;
shift = im;
for ii = 1:r
  xstar = round(x(ii));
  right(ii,1:xstar,:) = 255;
  left(ii,xstar:c,:) = 255;
end
fall = abs(round(fall));
for ii = 1:r
    if ii == 540
        ii = 540;
    end

    if ii > fall
        r0 = round(x(ii-fall));
    else
        r0 = round(x(1));
    end
    leftrow = ii - fall;
    if leftrow <= 0
        leftrow = 1;
    end
    xstar = round(x(ii));
    l0 = 1 + (r0-xstar);
    len = length(l0:r0);
    shift(ii,1:len,:) = left(leftrow,l0:r0,:);
    shift(ii,xstar:c,:) = right(ii,xstar:c,:);
end



%figure()
%imshow(left)
%figure()
%imshow(right)
%figure()
%imshow(shift)







% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
