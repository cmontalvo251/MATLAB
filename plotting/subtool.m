function subtool(row,column,x,y,name,ylabels,xname,width,type,titlename)

numdata = row*column;

[r,c] = size(y);
maxRC = max([r c]);

if maxRC < numdata
  disp('Not Enough Data for Subplot')
  return
end

loc = find(maxRC == [r c]);

if nargin > 4
  h1 = figure('Name',name);
  set(h1,'color','white')
end
ylabelflag = 0;
if nargin > 5
  if length(ylabels) == numdata
    ylabelflag = 1;
  end
else
  ylabels = '';
end
if nargin < 7
  xname = '';
end
if nargin < 8
  width = 1;
end
if nargin < 9
  type = 'b-';
end
if nargin < 10
  titlename = '';
end
if loc == 1
  %%plot rows independently
  for ii = 1:numdata
    subplot(row,column,ii)
    plot(x,y(ii,:),type,'LineWidth',width)
    if ii == 1
        title(titlename)
    end    
    if ylabelflag
      ylabel(ylabels{ii})
    elseif (ii > numdata/2) && ~ylabelflag
      ylabel(ylabels)
    end
    grid on
  end
  xlabel(xname)
elseif loc == 2
  %%plot columns independently
  for ii = 1:numdata
    subplot(row,column,ii)
    plot(x,y(ii,:),type,'LineWidth',width)
    if ii == 1
        title(titlename)
    end
    if ylabelflag
      ylabel(ylabels{ii})
    elseif (ii > numdata/2) && ~ylabelflag
      ylabel(ylabels)
    end
    grid on
  end
  xlabel(xname)
end

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
