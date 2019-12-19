function binarized = binary(data,flag,thresh)

IN = data;

%%Put data in a column
[r,c,d] = size(data);
if d > 1
  %%Flatten image
  newdata = uint8((1/3)*(double(data(:,:,1))+double(data(:,:,2))+double(data(:,:,3))));
  data = newdata;
end

rawdata = zeros(r*c,1);
for ii = 1:r
  rawdata(((ii-1)*c+1):((ii-1)*c+c),1) = data(ii,:)';
end

sorted = sort(rawdata);
b_raw = zeros(r,c,length(thresh));
binarized = b_raw;

for ll = 1:length(thresh)
   for ii = 1:r
      for jj = 1:c
         if data(ii,jj) > thresh(ll)
            b_raw(ii,jj,ll) = 1;
         else
            b_raw(ii,jj,ll) = 0;
         end
      end
   end
   binarized(:,:,ll) = (b_raw(:,:,ll) == 1);
   %%Compute Area, Centroid and Orientation
end

if flag
  %%Plot Histogram of rawdata
  plottool(1,'Original Histogram',12,'Gray Level','Frequency')
  hist(sorted)
  %%plot original image
  plottool(1,'Original Image',12,'','')
  imshow(IN)
  %grayscale image
  plottool(1,'Grayscale Image',12,'','')
  imshow(data)
  for ll = 1:length(thresh)
     %binarized image
     %plottool(1,'Binarized Image',12,'','')
     %imshow(binarized(:,:,ll))
     %title(num2str(thresh(ll)))
  end
end
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
