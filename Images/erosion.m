function result = erosion(A,B)
%%function result = erosion(A,B)

%purge
%A = imread('Atest.png');
%B = imread('B4.png');

[r,c,d] = size(A);
if d > 1
  A = flattenimage(A);
  B = flattenimage(B);
end


%%Convert A to a double of 0 or 1
A(A==255) = 1;
B(B==255) = 1;
A = double(A);
B = double(B);

figure()
imshow(A)
figure()
imshow(B)

%%Invert A and B
AI = 1-A;
BI = 1-B;

%%Sum up all the white elements in inverted image
TotalA = sum(sum(AI));
TotalB = sum(sum(BI));

%%Get limits
[rA,cA] = size(A);
[rB,cB] = size(B);

%%Compute Center of B
xc = 0;
yc = 0;
for ii = 1:rB
  for jj = 1:cB
    xc = xc + ii*BI(ii,jj);
    yc = yc + jj*BI(ii,jj);
  end
end
xc = floor(xc/TotalB);
yc = floor(yc/TotalB);

%%Assume A is bigger so result is similar to A
result = zeros(rA+2*rB-2,cA+2*cB-2);
[rlimit,climit]=size(result);
BigB = result;
%%Pad AI with zeros
BigA = [zeros(rB-1,climit);[zeros(rA,cB-1) AI zeros(rA,cB-1)];zeros(rB-1,climit)];
threshold = TotalB;
%figure()
%%Move B through A
for ii = 1:(rlimit-rB)
  for jj = 1:(climit-cB)
    %%%Shift BI for visualisation
    %BigB = 0*BigB;
    %BigB(ii:ii+rB-1,jj:jj+cB-1) = BI;
    %BigB(BigA==1)=1;
    %imshow(BigB)
    %drawnow
    total = 0;
    for kk = 1:rB
      for ll = 1:cB
	sr = ii+kk-1;
	sc = jj+ll-1;
	if BigA(sr,sc)==1 && BI(kk,ll)==1
	  total = total + 1;
	end
      end
    end
    if total == threshold
      %disp(ii+jj)
      result(ii+xc,jj+yc) = 1;
    end
  end
end
%%invert result
result = 1-result;
%%remove excess whitespace
[rR,cR] = size(result);
sR = rR-rB-rA+1;
eR = rR-rB;
sC = cR-cB-cA+1;
eC = cR-cB;
result = result(sR:eR,sC:eC);
figure()
imshow(result)


% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
