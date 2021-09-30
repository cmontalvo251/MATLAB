%%%This will plot y vs x
clear
clc
close all %%This will close all current figures

%%Make a vector that goes from -5 to 5
x=-5:0.1:5;

%%%y = x^2

y = x.^2;

fig = figure(); %%%This opens a new figure
set(fig,'color','white') %%%This sets the figure white
set(axes,'FontSize',18) %%change the fontsize to 18
plot(x,y,'k-','LineWidth',2) %%plot my  first line
grid on %%%turn on a grid
hold on %%%allow multiple lines
plot(x,1./x.^2,'b-','LineWidth',2) %%%plot my second line
plot(x,x.^3,'r-','LineWidth',2)
xlabel('x') %%%label my x-axis
ylabel('y') %%label my y-axis
title('Example Plot') %%%add a title
legend('y=x^2','y=1/x^2','y=x.^3') %%%create a legend

%%%for line style type help plot
