clear
clc
close all

colors = {'b','g','r'};

delx = [0.1 0.5 1];

for idx = 1:3
    delxi = delx(idx);
    clear x
    x(1) = 0;
    jdx = 1;
    while x(jdx) <= 5-delxi
        x(jdx+1) = x(jdx) + delxi;
        jdx = jdx + 1;
    end
    xaxis = linspace(0,5,length(x));
    plot(xaxis,x,colors{idx})
    hold on
end