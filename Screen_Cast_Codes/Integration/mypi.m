function out = mypi(N)
close all

I = 0;

x = linspace(-1,1,N+1);
dx = x(2)-x(1);

%x = -1:N:1;
%dx = N;

%xa = linspace(-1,1,1000);
%y = sqrt(1-xa.^2);
%fig = figure();
%set(fig,'color','white')
%set(axes,'FontSize',18)
%plot(xa,y,'b-','LineWidth',2)
%hold on

%%%Integrate using Trapezoidal
for idx = 1:length(x)-1
    f1 = sqrt(1-x(idx)^2);
    f2 = sqrt(1-x(idx+1)^2);
    I = I + 0.5*(f1+f2)*dx;
%     xp = [x(idx) x(idx+1) x(idx+1) x(idx)];
%     yp = [0 0 f2 f1];
%     patch(xp,yp,[0 1 0])
%     hold on
%     title(['I = ',num2str(I)])
%     xlabel('t')
%     ylabel('f')
%     pause(0.1)
%     drawnow
end

out = 2*I;
