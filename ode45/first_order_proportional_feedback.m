%How's that?
function first_order_proportional_feedback()
close all

global kp f

figure()
hold on
pause
for kp = 0:10

%kp = 10;

%%%Time series
tout = linspace(0,10,1000);

%%%Simulate this with ode45
xinitial = 0;
[tode,xode] = ode45(@Derivs,tout,xinitial);
fode = 0*tode;
for idx = 1:length(tode)
	dxdt = Derivs(tode(idx),xode(idx));
	fode(idx) = f;
end

hold on
plot(tode,xode,'r--')
%plot(tode,fode)
drawnow
end

function dxdt = Derivs(t,x)
global kp f

xc = 1;
e = xc - x;
f = kp*e;

%%%Saturation Function
if abs(f) > 1
	f = 1;
end
dxdt = 3*f - 2*x;
