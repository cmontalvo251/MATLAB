function save_frame(filename)
%%%save_frame(filename)
%%%use this in conjunction with getfilename
%%%save_frame(getfilename(framenumber,maxgidits))

% papersize = get(gcf,'PaperSize');
% width = 3;
% height = 7;
% left = (papersize(1)-width)/2;
% bottom = (papersize(2)-height)/2;
% myfiguresize = [left,bottom,width,height];
% set(gcf,'PaperPosition',myfiguresize);
%set(gcf,'PaperPositionMode','auto')
% handles = get(0,'Children')
% set(handles,'units','pixels');
% set(handles,'OuterPosition',[100 10 100 200])
% print -djpeg -r100 filename
saveas(gcf,filename,'jpg');

% Copyright - Carlos Montalvo 2015
% You may freely distribute this file but please keep my name in here
% as the original owner
