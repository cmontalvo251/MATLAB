function [tfilter,y] = LowPass(u,t,wc)
%%This function will filter a signal using a 1st order Tustin Filter
%%The inputs are u,t, and wc, which are the input signal the time
%and the cutoff frequency
%%The outputs are the filtered time and the filtered signal
tfilter = t;
y = u;
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
disp(['Timestep = ',num2str(dt)])
tau = 1/wc;
disp(['Tau = ',num2str(tau)])
alfa = 2*tau/dt;
disp(['alfa = ',num2str(alfa)])
%%Filter Signal and time
for i = 1:max([rt,ct])-1
  y(i+1) = (u(i+1)+u(i)-y(i)*(1-alfa))/(alfa+1);
  tfilter(i+1) = (t(i+1)+t(i)-tfilter(i)*(1-alfa))/(alfa+1);
end

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
