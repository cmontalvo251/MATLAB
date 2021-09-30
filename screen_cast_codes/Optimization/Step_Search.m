function Step_Search()
clear
clc
close all

x = -5:0.01:5;
y = f(x);
plot(x,y)
hold on

step_size = 0.5;
x0 = -1;

colors = {'r','g','k','m','y','c','b'};
idx = 1;
iters = 0;

xiters = x0;

while step_size > 0.000001
    iters = iters + 1;
    xiters(iters) = x0;
    %%%These are my three sample points I'd like to check
    xsamples = [x0-step_size x0 x0+step_size];
    %%%%This is the function evaluated at my sample points
    fsamples = f(xsamples);
    %%%This is the minimum of the three
    fmin = min(fsamples);
    %%%%This is the vector location of my minimum
    loc = (fmin == fsamples); %%%This is a vector of 0's and 1's
    x0 = xsamples(loc) %%%%Grabbing the x that computs fmin = f(x)
    if loc(2) == 1 %%%Means that the minimum is the point you are sampling
        step_size = step_size/2;
        idx = idx + 1;
        if idx > length(colors)
            idx = 1;
        end
    end
    plot(x0,f(x0),[colors{idx},'*'],'MarkerSize',10)
    drawnow
    %pause(0.3)
end

absolute_error = abs(x0-exp(1))
iters

figure()
plot(xiters)

function y = f(x)

y = (x-exp(1)).^2 - 1;

%%%xopt is e and y opt is -1