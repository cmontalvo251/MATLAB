clear
clc
close all

x1 = 8:0.01:12;

line1 = 9.5 + 0.5*x1;
line2 = 9.4 + 0.51*x1;

plot(x1,line1)
hold on
plot(x1,line2)