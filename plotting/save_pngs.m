ii = 50;
while ~isempty(get(0,'CurrentFigure') )
    f = getfilename(ii,5);
    filename = ['Frame_',f];
    saveas(gcf,[filename,'.png'])
    close(gcf)
    ii = ii - 1;
end