purge

t = linspace(0,1,10000);
y = t.*(1-t);

[d,a,b,n,freq] = myfft(y,t,200,1,0);

d

plot(b)

figure()

plot(a)
hold on
plot(-1./(n.^2*pi^2),'r--')
