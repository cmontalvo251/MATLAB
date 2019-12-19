function [table,OUT] = myhisteq(data,N,flag)

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

%%Create Histogram Table
qkconstant = (2^N - 1)/(r*c);
graylevels = 0;
levels = 88;
numpixels = [];
n = 0;
cdf = [];
total = 0;
table = [];
qk = [];
for ii = 1:length(sorted)
  if sorted(ii) > levels
    levels = [levels;sorted(ii)];
    graylevels = graylevels + 1;
    numpixels = [numpixels;n];
    total = total + n;
    cdf = [cdf;total];
    qk = [qk;total*qkconstant];
    n = 1;
  else
    n = n + 1;
  end
end
numpixels = [numpixels;n];
total = total + n;
cdf = [cdf;total];
qk = [qk;total*qkconstant];
qkround = round(qk);
table = [levels,numpixels,cdf,qk,qkround];

%%Generate Image
OUT = 0*data;

for ii = 1:r
  for jj = 1:c
    oldlevel = data(ii,jj);
    row = find(levels==oldlevel);
    newlevel = qkround(row);
    OUT(ii,jj) = newlevel;
  end
end

if flag
  %%Plot Histogram of rawdata
  plottool(1,'Original Histogram',12,'Gray Level','Frequency')
  hist(sorted)
  %%plot original image
  plottool(1,'Original Image',12,'','')
  imshow(data)
  %%Plot Histogram of rounded data
  plottool(1,'Equalized Histogram',12,'Gray Level','Frequency')
  hist(qkround)
  xlim([0 260])
  %%Plot Equalized Image
  plottool(1,'Equalized Image',12,'','')
  imshow(OUT)
end

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
