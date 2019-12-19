clear
clc
close all

original = imread('q1jjy.png');

imshow(original)

clipped = original(:,1:550,:);

figure()
imshow(clipped)

%%%%Edge Detection Algorithm (Sobel Operator)
%%%Convert the image to black and white
bw = uint8((1/3)*(double(clipped(:,:,1))+double(clipped(:,:,2))+double(clipped(:,:,3))));
figure()
imshow(bw)

bwdbl = double(bw);

%%%Apply a mask in x
maskx = [-1 -2 -1;0 0 0;1 2 1];  %%SOBEL MASKS - GOOGLE THIS YOU WILL FIND IT
[r,c] = size(bw);
OUT = zeros(r-3,c-3);
for idx = 1:(r-3)
    for jdx = 1:(c-3)
        %rectangle('Position',[idx jdx 3 3])
        %drawnow
        bwsquare = bwdbl(idx:(idx+2),jdx:(jdx+2));
        res = maskx.*bwsquare;
        OUT(idx,jdx) = sum(sum(res));
    end
end
Gx = OUT;

figure()
imshow(Gx)

%%%Apply another mask in y
masky = [-1 0 1;-2 0 2;-1 0 1];
for idx = 1:(r-3)
    for jdx = 1:(c-3)
        %rectangle('Position',[idx jdx 3 3])
        %drawnow
        bwsquare = bwdbl(idx:(idx+2),jdx:(jdx+2));
        res = masky.*bwsquare;
        OUT(idx,jdx) = sum(sum(res));
    end
end
Gy = OUT;

figure()
imshow(Gy)

%%%Normalize the results of both masks
G = sqrt(Gx.^2 + Gy.^2);

%%%%Plot the result
figure()
imshow(G)

