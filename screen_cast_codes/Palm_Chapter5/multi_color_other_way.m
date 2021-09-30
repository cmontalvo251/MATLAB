clear
clc
close all

x = 1:10;
hat = [0.1 0.2 0.3];

bigy = [];

for idx = 1:length(hat)
    
    y = hat(idx).*x.^2;
    
    bigy = [bigy;y];
end

plot(x,bigy)
    

