function [t,y] = DerivativeFilter(u,t,wc,initialguess,threshold)
%%This function will calculate the derivative using a 1st order Tustin Filter
%%The inputs are u,t, wc, and initialguess which are the input signal, the time
%the cutoff frequency and the initial guess for the derivative
%%The outputs are the filtered time and the filtered signal
[ru,cu] = size(u);
[rt,ct] = size(t);
if (ru ~= rt) || (cu ~= ct)
  disp('Time and Input Signal are not the same size')
  return
end
if max([rt,ct]) < 2
  disp('input signal only contains one entry')
end
dt = t(2) - t(1);
tau = 1/wc;
alfa = 2*tau/dt;
y = u;
y(1) = initialguess;
%for i = 1:max([ru cu])-1
%  y(i+1) = (2*(u(i+1)-u(i))+y(i)*(2*tau-dt))/(2*tau+dt);
%end

y(2:end) = (u(2:end)-u(1:end-1))./(t(2:end)-t(1:end-1));


%%%Throw out ridiculously high variables.
y(isinf(y)) = 0;
%my = mean(y)
%y(y<my) = 0;
%y(y>-my) = 0;
y(abs(y)>threshold) = 0;

%%Run the signal through a low pass filter

[t,y] = LowPass(y,t,wc);

%xdot_f = (x(2:end)-x(1:end-1))./(quad_time(2:end)-quad_time(1:end-1));
%ydot_f = (y(2:end)-y(1:end-1))./(quad_time(2:end)-quad_time(1:end-1));

%%Filter the Time Signal
%[tfilter,tfilter] = LowPass(t,t,wc);

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
