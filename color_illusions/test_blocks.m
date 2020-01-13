purge

im = imread('identical-colors-big.jpg');
figure()
imshow(im)

imgray = flattenimage(im);
figure()
imshow(imgray)

imgraydbl = double(imgray);
figure()
mesh(imgraydbl)


%%%Edit image
imgraydbl(imgraydbl > 150) = 137;
for ii = 288:582
    for jj = 350:-1:225
        if imgraydbl(jj,ii) ~= 137;
            imgraydbl(jj,ii) = 137;
        end
    end
end

imgrayback = uint8(imgraydbl);
figure()
imshow(imgrayback)





