ii = 50;
while ~isempty(get(0,'CurrentFigure') )
    f = getfilename(ii,5);
    saveas(gcf,['Frame_',f,'.png'])
    close(gcf)
    ii = ii - 1;
end
disp('Converting All Pdfs to State.pdf')
system('convert *.png State.pdf')
system('rm Frame_*.png') 
system('evince State.pdf')
