function result = gerosion(A,B)
%%function result = dilation(A,B)

figure()
imshow(A)
figure()
imshow(B)

%%Get limits
[rA,cA] = size(A);
[rB,cB] = size(B);

%%Assume A is bigger so result is similar to A
result = 0*A;
[rlimit,climit]=size(result);
BigB = result;
s = floor(rB/2)
del = (rB-s)/2
%%Move B through A
for ii = s+1:(rlimit-rB)
  for jj = s+1:(climit-cB)
    result(ii,jj) = min(min(A(ii-del:ii+del,jj-del:jj+del)));
  end
end
%%invert result
figure()
imshow(result)


% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
