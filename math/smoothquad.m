function out = smoothquad(in,N)

disp('Smoothing')

[r,c] = size(in);
out = in;

if r ~= c
  disp('Matrix must be square')
  return
end

%%Make left side equal to right side
leftright = 0.5.*(in(:,1) + in(:,end));
out(:,1) = leftright;
out(:,end) = leftright;

%%Make top equal to bottom
topbottom = 0.5.*(out(1,:) + out(end,:));
out(1,:) = topbottom;
out(end,:) = topbottom;

%%Smooth more points 
if N > 0
  %%Left to right
  for ii = 2:N+1
    out(:,ii) = 0.5.*(out(:,ii-1)+out(:,ii+1));
    out(:,end-ii+1) = 0.5*(out(:,end-ii)+out(:,end-ii+2));
  end
  %%top to bottom
  for ii = 2:N+1
    out(ii,:) = 0.5.*(out(ii-1,:)+out(ii+1,:));
    out(end-ii+1,:) = 0.5*(out(end-ii,:)+out(end-ii+2,:));
  end
end






% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
