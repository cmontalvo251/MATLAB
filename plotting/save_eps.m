ii = 37;
while ~isempty(get(0,'CurrentFigure') )
    f = getfilename(ii,5);
    filename = ['Frame_',f];
    saveas(gcf,[filename,'.epsc'])
    system(['mv ',filename,'.epsc ',filename,'.eps'])
    close(gcf)
    ii = ii + 1;
end