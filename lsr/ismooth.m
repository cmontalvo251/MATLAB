function [xout,yout] = ismooth(xin,yin,N,Order)

if Order <= 1
  Order = 2;
end

xout = xin;
yout = yin;

if length(xin) >=2
slope = (yin(2)-yin(1))/(xin(2)-xin(1));
%slope = 0;
% P = polyfit(xin,yin,N);

xout = linspace(xin(1),xin(end),N);

H = [];
for ii = 1:Order-1
  H = [H xin.^(ii+1)];
end

X = yin-yin(1)-slope.*xin;

theta = inv(H'*H)*H'*X;
yout = yin(1) + slope.*xout;
extra = Order.*yout;
for ii = 2:Order
  extra = extra + theta(ii-1).*xout.^ii;
end
yout = yout + extra;
%%Set certain values = 0
%loc = find(yout < 0,1);
%yout(yout < 0) = 0;
% yout = polyval(P,xout);
end
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
