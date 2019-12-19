function [xdata,ydata] = getDatafromFig()

h = gcf;
axesObjs = get(h,'Children');
dataObjs = get(axesObjs,'Children');
xdata_cell = get(dataObjs{2},'XData');
ydata_cell = get(dataObjs{2},'YData');

xdata = [];
ydata = [];

for idx = 1:length(xdata_cell)
    xdata = [xdata;xdata_cell{idx}];
    ydata = [ydata;ydata_cell{idx}];
end

%%Flip
xdata = xdata(end:-1:1,:);
ydata = ydata(end:-1:1,:);
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
