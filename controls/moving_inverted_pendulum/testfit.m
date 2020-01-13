clear
clc
close all

A = dlmread('data.txt');

y = A(:,1);
t = A(:,2);

%plot(t,y)

left = find(abs(y) == max(abs(y)));

tleft = t(left:end);
yleft = y(left:end);

%plot(tleft,yleft)

yleftabs = abs(yleft);

%plot(tleft,yleftabs)
%hold on

yavg = [];
tavg = [];
skip = 1000;
for idx = 1:skip:length(tleft)-skip
    tavg = [tavg;tleft(idx)];
    yavg = [yavg;max(yleftabs(idx:(idx+skip)))];
end

%plot(tavg,yavg,'rs')

a = log(yavg/yavg(1));

tnoinf = tavg;

tnoinf(abs(a)==Inf) = [];

dt = tnoinf - tavg(1);

a(abs(a)==Inf) = [];

tau = -mean(a(2:end)./dt(2:end));

yfit = yavg(1)*exp(-tau*(tleft-tleft(1)));

%plot(tleft,yfit,'r-')

right = find(yfit < 0.2*yfit(1),1);

tlr = tleft(1:right);
ylr = yleft(1:right);

%plot(tlr,ylr)