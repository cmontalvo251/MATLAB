close all
clear

%%Flags
EPIC = 1;

if EPIC
  epicguess = dlmread('EpicGuess.OUT');
  epicactual = dlmread('EpicActual.OUT');
  time = epicactual(:,1);
  mode = {'v(ft/s)','q(rad/s)','w(ft/s)','r(rad/s)'};
  for ii = 2:5
    plottool(1,'Epicyclic',12,'Time(sec)',mode{ii-1})
    plot(time,epicactual(:,ii),'b-')
    plot(time,epicguess(:,ii),'r-')
    legend('Actual','Guess')
    %xlim([0 EPICTime])
  end
  res = abs(epicguess-epicactual);
  J = sum(sum(res').^2)/length(epicactual(:,1));
end

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
