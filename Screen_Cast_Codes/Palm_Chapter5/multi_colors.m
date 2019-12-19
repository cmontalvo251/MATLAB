clear
clc
close all

colors = {'b-','k-','g-'};


x = 1:10;
hat = [0.1 0.2 0.3];

for idx = 1:length(colors)
    
    y = hat(idx).*x.^2;
    
    plot(x,y,colors{idx},'LineWidth',2)
    
    hold on
end

legend('y=0.1x^2','y=0.2x^2','y=0.3x^2')

xlim([1 10])
ylim([0 15])
