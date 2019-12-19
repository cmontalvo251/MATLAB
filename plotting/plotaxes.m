function plotaxes()
%%will plot black axes on current plot

H = get(gca);

xlimit = H.XLim;
ylimit = H.YLim;

plot([xlimit(1) xlimit(2)],[0 0],'k-')
plot([0 0],[ylimit(1) ylimit(2)],'k-')
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
