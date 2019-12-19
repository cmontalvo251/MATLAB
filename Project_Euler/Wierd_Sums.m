purge

x = 100; %I start with 10 apples

N = 100;

xactual = zeros(N,1);
xaverage = zeros(N,1);
xsum_vec = zeros(N,1);
xsum = x;

for ii = 1:N
    xactual(ii) = x;
    xsum_vec(ii) = xsum;
    xaverage(ii) = xsum/ii;
    %x = x + (-1)^(ii+1); %%S1
    x = x + (-1)^(ii+1)*ii;
    xsum = xsum + x;
end

nvec = 1:N;

plot(nvec,xactual,'b-','LineWidth',2)
hold on
plot(nvec,xaverage,'r-','LineWidth',2)
hold on
%plot(nvec,xsum_vec,'g-','LineWidth',2)
%legend('Actual','Average','Sum')
legend('Actual','Average')
