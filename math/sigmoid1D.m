purge

t = 0:0.01:1;

%y = 3*x.^2.*(1-x) + x.^3;

p0y = 0;
p1y = 0;
p2y = 1;
p3y = 1;

p0x = 0;
N_Smooth_Frames = 20;
tau = 1.0;
p1x = tau*N_Smooth_Frames;
p2x = (1-tau)*N_Smooth_Frames;
p3x = N_Smooth_Frames;

%y = (1-x).^3*p0 + 3*(1-x).^2.*x*p1 + 3*(1-x).*x.^2*p2 + x.^3*p3;

F = (1-t).^3*p0x + 3*(1-t).^2.*t*p1x + 3*(1-t).*t.^2*p2x + t.^3*p3x;
y = (1-t).^3*p0y + 3*(1-t).^2.*t*p1y + 3*(1-t).*t.^2*p2y + t.^3*p3y;

plot(F,y)

%%%THIS IS COOL BUT YOU CAN"T CHANGE THE ROLL OFF FOR SOME REASON


% PSIY = x;
% lowerbound = 0.0001;
% upperbound = 0.99;

% breakpt = 0.5;

% b = log(1/lowerbound-1);
% a = (log(upperbound)-b)/breakpt;
% PSIY =  1./(1+exp(a*abs(x)+b));
% plot(x,PSIY)

%%%%THIS DOESN"T WORK BECAUSE IT DOESN"T ENFORCE MAX AND MIN VALUES

%y = a1*x + a2*x.^2 + a3*x.^3 + a4*x.^4 + a5*x.^5;

%1 = a1*1 + a2*1.^2 + a3*1.^3 + a4*1.^4 + a5*1.^5
%0.5 = a1*0.5 + a2*(0.5)^2 + a3*(0.5)^3 + a3

%yprime = a1 + 2*a2*x + 3*a3*x.^2

%d = a1 + 2*a2*0.5 + 3*a3*(0.5)^2 + 4*a4*(0.5)^3 + 5*a5*(0.5)^4

% d = 1;

% Y = [1;0.5;d;0;0];

% H = [1 1 1 1 1;0.5 0.5^2 0.5^3 0.5^4 0.5^5;1 1 3*0.5^2 4*(0.5)^3 ...
%      5*(0.5)^4;1 0 0 0 0;1 2 3 4 5];

% Astar = inv(H'*H)*H'*Y;

% a1 = Astar(1);
% a2 = Astar(2);
% a3 = Astar(3);
% a4 = Astar(4);
% a5 = Astar(5);

% y = a1*x + a2*x.^2 + a3*x.^3 + a4*x.^4 + a5*x.^5;

% plot(x,y)






% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
