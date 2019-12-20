clear
clc
close all

%%%%Visualize Phase Lines
alfa = -2; 

%%%%alfa > 0, 1 eq , 1 stable

%%%%alfa < 0, 3 eq , 2 stable 1 unstable

xdot = linspace(-10,10,100);
x = linspace(-10,10,100);

bata = 1;
c = 2;
figure()
hold on
for idx = 1:length(x)
    for jdx = 1:length(xdot)
        xdbldot = -c*xdot(jdx) - alfa*x(idx) - bata*x(idx).^3;
        plot3(x(idx),xdot(jdx),xdbldot,'b*','MarkerSize',10)
    end
end
xlabel('x')
ylabel('\dot{x}')
zlabel('\ddot{x}')

        
    

