%function Pic2Dots(picname,numgrids,maxradius)
%%This function will explore converting a picture to dots
%function Pic2Dots(picname,numgrids,maxradius)
%The inputs are the picture name the number of grids you want to
%discretize the grid to and the maximum radius of the dots
picname = 'crg_oct2010Edit.jpg';
numgrids = 200;
maxradius = 0.1;

close all
slopeint = maxradius;
ratio = numgrids;
pic = imread(picname);

[r c w] = size(pic);

subplot(2,2,1)
imshow(pic)
title('Original Image')

%%Gray Scale Image
picdbl = double(pic);
for ii = 1:r
   for jj = 1:c
      avg = sum(picdbl(ii,jj,1:3))/3;
      picdbl(ii,jj,1) = avg;
   end
end
picdbl = picdbl(:,:,1);
picbw = uint8(picdbl);
picdblbw = picdbl;

subplot(2,2,2)
imshow(picbw)
title('Grayscale')
%%Now use dotting technique(radius of dot is proportional to
%average value of cell from 0 to 255)
%%first break picture into a grid based on certain ratio
radmat = zeros(ratio,ratio);
lociimat = radmat;
locjjmat = radmat;
if ratio < r && ratio < c
   %%Check to see if ratio is compatible with number of rows
   remove = mod(r,ratio);
   disp(['Cropping Photo'])
   if remove
      %%need to change number of rows
      disp(['Removing ',num2str(remove),' rows'])
      picdblbw = picdblbw(1:end-remove,:);
   end
   newr = r-remove;
   cellheight = (r-remove)/ratio;
   %%Check to see if ratio is compatible with number of columns
   remove = mod(c,ratio);
   if remove
      %%need to change number of columns
      disp(['Removing ',num2str(remove),' columns'])
      picdblbw = picdblbw(:,1:end-remove);
   end
   newc = c-remove;
   cellwidth = (c-remove)/ratio;
   %%Now move through grid
   ccell = 0;
   disp('Creating Dots')
   for columnstart = 1:cellwidth:(newc-cellwidth)+1
      for rowstart = 1:cellheight:(newr-cellheight)+1
         ccell = ccell + 1;
         %disp(['Current Cell = ',num2str(ccell)])
         %%Now move through current cell and find average value
         avg = 0;
         num = 0;
         %rowstart
         %columnstart
         for ii = rowstart:rowstart+cellheight-1
            for jj = columnstart:columnstart+cellwidth-1
               avg = avg + picdblbw(ii,jj);
               num = num + 1;
            end
         end
         avg = avg/num;
         locii = rowstart - 1 + cellheight/2;
         locjj = columnstart - 1 + (cellwidth/2);
         %%use avg to compute dot radius
         slope = -(slopeint)/255;
         radius = slopeint + slope*avg;
         radmat(ccell) = radius;
         lociimat(ccell) = locii;
         locjjmat(ccell) = locjj;
      end
   end
   %%Create Mesh plot of radiuses
   x = linspace(0,newc,ratio);
   y = linspace(0,newr,ratio);
   y = y(end:-1:1);
   [xx,yy] = meshgrid(x,y);
   subplot(2,2,3)
   contourf(xx,yy,-radmat)
   axis([0 newc 0 newr])
   title('Contour Plot')
   subplot(2,2,4)
   mesh(xx,yy,radmat)
   title('Mesh Plot')
   axis([0 newc 0 newr])
   view(0,90)
   %OK now time to make the dots
   figure()
   for ii = 1:ratio^2
      xloc = (locjjmat(ii)-radmat(ii));
      yloc = (lociimat((ratio^2)-ii+1)-radmat(ii));
      width = 2*radmat(ii);
      length = 2*radmat(ii);
      if width && length
        rectangle('curvature',[1 1],'position',[xloc,yloc,width,length],'facecolor','k')
      end
   end
   axis equal
   figure()
   contourf(xx,yy,-radmat)
   title('Contour Plot')
   figure()
   mesh(xx,yy,radmat)
   title('Mesh Plot')
   view(0,90)
else
   disp('Ratio too large')
end

