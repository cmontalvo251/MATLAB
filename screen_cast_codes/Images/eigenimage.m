clear
clc
close all
%%%Read in Image file

A = imread('demo-image2.jpg');

%%%Show image

imshow(A)

%%%Flatten to grayscale
%G = flattenimage(A);

%%%Use built-in MATLAB function
G = rgb2gray(A);

%%%Show flattened image

figure()
imshow(G)

%%%Convert image to double

Gdbl = double(G);

%%%Deconstruct Matrix using svd

[U,S,V] = svd(Gdbl);

%%%It is a property of linear algebra that

Gsvd = U*S*V';

%%%Convert to uint8

Gsvd8 = uint8(Gsvd);

%%%Make sure math works

figure()
imshow(Gsvd8)

%%%It is another interesting property that S = sqrt(eigenvalues)
%%%If you take a look at S you will see that it is a diagonal matrix
%%%where S(1,1) is the biggest value. Thus we can reconstruct S
%%%by setting all other eigenvalues to zero

[r,c] = size(S);
Szero = zeros(r,c);

%%%In this loop we will reconstruct the Gray scale image
%%%But add an eigenvalue each time we do it.
figure()
pause
for ii = 1:r
    ii
    Szero(ii,ii) = S(ii,ii);
    Gsvdii = U*Szero*V';
    Gsvdii8 = uint8(Gsvdii);
    imshow(Gsvdii8)
    pause %%%We will pause here. If you keep hitting
    %enter you should see the image slowly develop into
    %our original image. r = 682 for this image to you
    %have to hit enter 682 times. Thus if you want to end early
    %just hit CTRL-C.    
end
    
    




