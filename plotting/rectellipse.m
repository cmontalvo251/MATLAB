%%%%x^4/a^4 + y^4/b^4 = 1

%%%x^4 = a^4*(1-y^4/b^4)

%%%x^2 = +-sqrt(a^4*(1-y^4/b^4))

%%%x = +-sqrt(+-sqrt(a^4*(1-y^4/b^4));

close all
clear
clc

r0 = 4;

rmax = sqrt(r0^2+r0^2);

theta = linspace(0,pi/4,100);


%%% GAUSSIAN FUNCTION
% x = linspace(-5,5,100);
% r = r0 + (rmax-r0)*exp(-x.^2);

% %%STRAIGHT LINE
% r = r0./cos(theta);

%%%%SIGMOID FUNCTION
% delxz = linspace(-2,2,100);%0:0.01:(pi/2);
% lowerbound = 0.0001;
% upperbound = 0.99;
% breakpt = 1;
% b = log(1/lowerbound-1);
% a = (log(upperbound)-b)/breakpt;
% delxz = abs(delxz);
% r = r0+(rmax-r0)*(1-1./(1+exp(a*abs(delxz)+b)));

% figure()
% plot(theta,r)

%break

% x = r.*cos(theta);
% y = r.*sin(theta);
% figure()
% plot(x,y)
% axis equal

%%%SUPER ELLISPSE

r_vec = 2:5;

for ii = 1:length(r_vec)
  a = 1;
  b = 1;
  theta = linspace(0,pi/2,1000);
  r0 = r_vec(ii);
  x1 = a*cos(theta).^(2/r0);
  y1 = b*sin(theta).^(2/r0);
  x2 = -x1;
  y2 = y1;
  x3 = x2;
  y3 = -y1;
  x4 = x1;
  y4 = y3;
  plot(x1,y1)
  hold on
  plot(x2,y2) 
  plot(x3,y3)
  plot(x4,y4)
  drawnow
  axis equal
end

r = sqrt(x1.^2+y1.^2);


r2 = sqrt(cos(theta).^(4/5)+sin(theta).^(4/5));

figure()
plot(theta,r)
hold on
plot(theta,r2,'r--')
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
