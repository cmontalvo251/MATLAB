function quadcopter()
close all

%%%%For integral gain your state vector increases by one so we have
%%%It also increase again when I add sensor dynamics
%%%position, velocity, integral of error, measured position from GPS
initial = [0;0;0;0];
time_span = [0 20]; %%integrate from 0 to 10 seconds
[tout,xout] = ode45(@Derivs,time_span,initial);

%%%Plot stuff
plot(tout,xout(:,1))
xlabel('Time (sec)')
ylabel('Height (m)')
hold on
plot(tout,ones(length(tout),1)*5,'r--')

function dxdt = Derivs(t,x)

z = x(1);
zdot = x(2);
eint = x(3); %%%This is a third state. Which is the integral of error
ztilde = x(4); %%%In order to add sensor dynamics I need to add ANOTHER state

Ts = 4; %%%GPS takes 4 seconds to settle
%%%GPS is too slow. We need some thing faster.
Ts = 1/100; %%Let's assume we use a barometer at 100 Hz
a = 4/Ts; %%%a is from the transfer function in H
g = 9.81;
m = 0.6 + 0.5;

%%%%This comes from converting the H sensor transfer function to the time
%%%%domain
ztildedot = a*(z - ztilde);

%%%Proportional Control(no good bruh.) Let's add Derivative Gain
%%%(Bruhhhhhhhhh. Let's do it for the kids bruh.) 
zcommand = 5;
zdotcommand = 0;
kp = 10;
kd = 4;
ki = 5;
%%%Alll of these equations have changed to ztilde so that you are feeding
%%%back the measured altitude using GPS
T = kp*(zcommand - ztilde);% + kd*(zdotcommand - zdot) + ki*eint;
%%%kp or proportional gain only will make this system oscillate forever.
%%%The reason why this system oscillates forever is because it has two
%%%poles at the origin. It's marginally stable. Thus a kp controller will
%%%make it oscillate for ever. Open loop it will just shoot to infinity.
T = kp*(zcommand - ztilde) + kd*(zdotcommand - ztildedot);% + ki*eint;
%%%it doesn't reach the commanded value zcommand. This is called steady
%%%state error. So what do I do to fix it? Add in integral gain.
T = kp*(zcommand - z) + kd*(zdotcommand - ztildedot) + ki*eint; %%%Don't forget to add ki*eint

%%%THese are the EOMS of the quad
zddot = T/m - g;

eintdot = (zcommand - ztilde); %%%The derivative of the integral or error using 
%the fundamental theorem of calculus is just the error itself so zc-z

dxdt = [zdot;zddot;eintdot;ztildedot]; %%%Then you just add eintdot to the derivatives vector
%%%You also need to add ztildedot to dxdt when you add sensor dynamics