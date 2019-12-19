clear
clc
close all

original = imread('flowers-02.jpg');

%%%%First let's go over plotting the image

imshow(original)

%%%%Then let's go over the three layers

icolor = original;
icolor(:,:,1) = 0; %%%icolor is still NxPx3
icolor(:,:,2) = 0;

%%1 = red,2 = green, 3 = blue

%figure()
%imshow(icolor)


%%%%%Finally let's go over uint8
A = uint8(zeros(10,10));
B = uint8(zeros(10,10)+255);
C = uint8(zeros(10,10));

%figure()
%imshow([A,B,C])

%%%I want to convert my original image to black and white
bw = uint8((1/3)*(double(original(:,:,1))+double(original(:,:,2))+double(original(:,:,3))));

%figure()
%imshow(bw)

%figure()
%contour(double(bw))


%%%Shrink the image
skip = 10;
shrink = original(1:skip:end,1:skip:end,:);

figure()
imshow(shrink)

figure()
bw_shrink = uint8((1/3)*(double(shrink(:,:,1))+double(shrink(:,:,2))+double(shrink(:,:,3))));
surf(double(bw_shrink))


