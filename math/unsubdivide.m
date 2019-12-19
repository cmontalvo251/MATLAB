function out = unsubdivide(in,N)
out = in;
disp(['N = ',num2str(N)])
if N>0
  for ii = 2:length(in)-1
    out(ii) = (in(ii-1)+in(ii)+in(ii+1))/3;
  end
  N = N-1;
  out = unsubdivide(out,N);
else
  out = in;
end



  
  
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
