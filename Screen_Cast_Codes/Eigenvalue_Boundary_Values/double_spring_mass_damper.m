clear
clc
close all
x0 = [0;1;0;1];
k1 = 200;k2 = 200;
m1 = 1;m2 = 1;
A = [0 1 0 0;(-k1-k2)/m1 0 k2/m1 0;0 0 0 1;k2/m2 0 -k2/m2 0];
t = 0:0.01:1; 
x = zeros(4,length(t));
for idx = 1:length(t)
  x(:,idx) = expm(A.*t(idx))*x0;
end
x1 = x(1,:);
xdot1 = x(2,:);
x2 = x(3,:);
xdot2 = x(4,:);

[V,L] = eig(A);
a = inv(V)*x0;
xEigen = zeros(4,length(t));
for idx = 1:length(t)
    for n = 1:4
        xEigen(:,idx) = xEigen(:,idx) + a(n)*V(:,n)*exp(L(n,n)*t(idx));
    end
end

fig = figure();
set(axes,'FontSize',14)
set(fig,'color','white')
plot(t,x1,'b-','LineWidth',2)
grid on
hold on
plot(t,x2,'r-','LineWidth',2)
plot(t,xEigen(1,:),'r--')
plot(t,xEigen(3,:),'b--')
legend('Position 1','Position 2')
xlabel('Time (sec)')
ylabel('Position (m)')
fig = figure();
set(axes,'FontSize',14)
set(fig,'color','white')
plot(t,xdot1,'b-','LineWidth',2)
grid on
hold on
plot(t,xdot2,'r-','LineWidth',2)
plot(t,xEigen(2,:),'b--')
plot(t,xEigen(4,:),'r--')
legend('Velocity 1','Velocity 2')
xlabel('Time (sec)')
ylabel('Velocity (m/s)')

fig = figure();
set(axes,'FontSize',14)
set(fig,'color','white')
grid on
hold on
plot(t,x-xEigen,'LineWidth',2)

