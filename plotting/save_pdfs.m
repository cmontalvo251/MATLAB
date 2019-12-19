ii = 50;
while ~isempty(get(0,'CurrentFigure') )
    f = getfilename(ii,5);
    saveas(gcf,['Frame_',f,'.pdf'])
    close(gcf)
    ii = ii - 1;
end
