function simulation()
global thrust rudder

close all

timestep = 0.001;

t = 0:timestep:10;

thrust = 0;
rudder = 0;
x0 = 0;
y0 = 0;
psi0 = 0;
u0 = 0;
r0 = 0;

xk = [x0;y0;psi0;u0;r0];

fig = figure('Name','Boat','keypressfcn',@keypress,'KeyReleaseFcn',@keyrelease);
set(fig,'color','white');
set(axes,'FontSize',18)

for idx = 1:length(t)
    %%%%%Animation Loop
    cla;

    x = xk(1);
    y = xk(2);
    psi = xk(3);
    plot(x,y,'b.','MarkerSize',20)
    hold on
    plot([x x + 10*cos(psi)],[y y + 10*sin(psi)],'b-','LineWidth',2)
    title([num2str(t(idx)),' thrust = ',num2str(thrust),' rudder = ',num2str(rudder)])
    
    axis([-100 100 -100 100])
    
    drawnow
    
    %%%Integrate (RK4) - THIS IS THE ONLY 7 LINES OF CODE I WILL TEST YOU
    %%%ON
    tk = t(idx);
    k1 = Derivs(tk,xk);
    k2 = Derivs(tk+timestep/2,xk+k1*timestep/2);
    k3 = Derivs(tk+timestep/2,xk+k2*timestep/2);
    k4 = Derivs(tk+timestep,xk+k3*timestep);
    phi = (1/6)*(k1 + 2*k2 + 2*k3 + k4);
    xk1 = xk + phi*timestep;
    
    %%%Step my state
    xk = xk1;    
end

function keypress(varargin) %%%varargin - variable number of arguments
global thrust rudder

key = get(gcbf,'CurrentKey');  %%%Get current state of keyboard

switch key
 case 'uparrow'
    thrust = thrust + 1;
 case 'downarrow'
    thrust = thrust - 1;
 case 'leftarrow'
    rudder = rudder + 1;
 case 'rightarrow'
    rudder = rudder - 1;
end


function keyrelease(varargin)