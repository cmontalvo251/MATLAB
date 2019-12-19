function [toutL,xoutL,uoutL] = olde(functionH,tspan,xinitial,uinitial,timestep,next)
threshold = 0;
toutL = tspan(1):timestep:tspan(end);
[n,d] = size(xinitial);
xoutL = zeros(n,length(toutL));
xoutL(:,1) = xinitial;
[n,d] = size(uinitial);
uoutL = zeros(n,length(toutL));
uoutL(:,1) = uinitial;
for ii = 2:length(toutL)
  if round(100*toutL(ii)/toutL(end)) >= threshold
    disp(['Simulation ',num2str(threshold),' %Complete'])
    threshold = threshold + next;
  end
  [xoutL(:,ii),uoutL(:,ii)] = feval(functionH,toutL(ii),xoutL(:,ii-1));
end


% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
