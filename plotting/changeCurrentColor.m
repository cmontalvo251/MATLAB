function changeCurrentColor(color_str)

%%%Get current line
h = gca;
c = get(h,'Children');
clast = c(1);
%%%Strip dashes
l = find(color_str=='-');
color_str(l) = [];
set(clast,'Color',rgb(color_str))
% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
